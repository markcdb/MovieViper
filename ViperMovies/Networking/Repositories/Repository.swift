//
//  Repository.swift
//  Movie
//
//  Created by Mark Christian Buot on 03/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {
    
    associatedtype T: Codable
    
    func getList<U>(params: U?,
                    completion: @escaping (([T]?, Error?) -> ()))
    
    func get<U>(params: U?,
                completion: @escaping ((T?, Error?) -> ()))
    
    func create<U>(params: U?,
                   completion: @escaping ((T?, Error?) -> ()))
    
    func edit<U>(params: U?,
                 completion: @escaping ((T?, Error?) -> ()))
    
    func delete<U>(params: U?,
                   completion: @escaping ((T?, Error?) -> ()))
    
    func retry()
}

protocol MainRepositoryProtocol {
    //Screen specific request
    func request(_ req: Request?)
}

class Repository<T: Codable>: MainRepositoryProtocol, RepositoryProtocol {
   
    typealias T       = T
    typealias ArrayC  = (([T]?, Error?) -> ())
    typealias SingleC = ((T?, Error?) -> ())
    
    var background = DispatchQueue.global(qos: .userInitiated)
    var main       = DispatchQueue.main
    var group      = DispatchGroup()
    
    var api: API?
    var requests: [Request] = [] {
        didSet {
            if requests.isEmpty == false {
                request()
            }
        }
    }
    
    init() {
        api = API(host: NetworkConfig.baseUrl)
    }

    func getList<U>(params: U?,
                    completion: @escaping ArrayC) {}
    
    func get<U>(params: U?,
                completion: @escaping SingleC) {}
    
    func create<U>(params: U?,
                   completion: @escaping SingleC) {}
    
    func edit<U>(params: U?,
                 completion: @escaping SingleC) {}
    
    func delete<U>(params: U?,
                   completion: @escaping SingleC) {}
    
    func retry() {
        for req in requests {
            request(req)
        }
    }

    internal func request(_ req: Request? = nil) {
        // Construct the request object (ListRequest)
        var request: Request?
        
        if let req  = req {
            request = req
        } else {
            request = requests.last
        }
        
        api?.request(request: request)
    }
    
    internal func createSuccessAndFail<T: Codable>(_ request: Request,
                                                   completion: @escaping ((T?, Error?) -> ()),
                                                   operationBlock: ((inout T?, DispatchGroup) -> ())? = nil ) {
        
        request.successCompletion = {[weak self] response in
            guard let self = self else { return }
            self.background.async {
                if response.data.isEmpty {
                    self.main.async {
                        completion(nil, nil)
                    }
                    
                    return
                }
                
                do {
                    self.group.enter()
                    
                    var object: T?
                    
                    if let obj = try? JSONDecoder().decode(T.self,
                                                              from: response.data) {
                        object = obj
                    } else if let arrayCodable = try? JSONDecoder().decode(ResponseArray<T>.self,
                                                                           from: response.data) {
                        if let page = arrayCodable.page,
                            let totalPage = arrayCodable.total_pages,
                            page > totalPage {
                            throw self.injectLastPageError()
                        }
                        
                        if let res = arrayCodable.results {
                            object = res
                        }
                    }

                    if let block = operationBlock {
                        block(&object, self.group)
                    } else {
                        self.group.leave()
                    }
                    
                    if let index = self.requests.firstIndex(where: { $0.id == request.id }) {
                        self.requests.remove(at: index)
                    }
                    
                    self.group.notify(queue: self.main, execute: {
                        completion(object, nil)
                    })
                } catch let error {
                    
                    self.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        
        request.errorCompletion = { response in
            
            completion(nil, response)
        }
        
        requests.append(request)
    }
    
    func injectLastPageError() -> ErrorResponse {
        
        return ErrorResponse(statusCode: Strings.pagingLimit,
                             error: Titles.pagingLimit)
    }
}

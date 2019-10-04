//
//  API.swift
//  Movie
//
//  Created by Mark Christian Buot on 03/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import Networking

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

class API {
    
    internal var networking: Networking?
    
    internal var mocking: Bool {
        if ProcessInfo.processInfo.environment[Paths.testPath] != nil {
            return true
        }
        return false
    }
    
    internal var host: String
    
    init(host: String) {
        
        self.host = host
        
        self.networking = Networking(baseURL: host)
    }
    
    private func createQueryString(from parameters: [String: Any]) -> String {
        var queryString = blank_
        
        if parameters.keys.count > 0 {
            queryString.append("?")
            let sortedKeys = parameters.keys.sorted()
            for key in sortedKeys {
                queryString.append("\(key)=\(parameters[key] ?? blank_)")
                if sortedKeys.last != key {
                    queryString.append("&")
                }
            }
        }
        
        return queryString
    }
    
    internal func request(request: Request?) {
        guard let request = request else { return }
        
        var parametersDict                 = request.parameters
        let method                         = request.method
        let path                           = request.path
        
        let completion: (_ result: JSONResult) -> Void = request.getCompletion()
        
        //Inject the API Key
        injectAPIKey(parameters: &parametersDict)

        print("Requesting from: \(path)\nWith: \(method.rawValue)")
        
        //Check the request type
        switch method {
        case .get:
            var queryString   = blank_
            
            if let dict = parametersDict {
                queryString   = createQueryString(from: dict)
                queryString   = queryString.addingPercentEncoding(
                                withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? blank_
            }
          
            self.networking?.get(path,
                                 parameters: parametersDict,
                                 completion: completion)
        case .post:
            
            self.networking?.post(path,
                                  parameters: parametersDict,
                                  completion: completion)
        case .put:
            
            self.networking?.put(path,
                                 parameterType: .json,
                                 parameters: parametersDict,
                                 completion: completion)
        case .delete:

            self.networking?.delete(path,
                                    parameters: parametersDict,
                                    completion: completion)
        }
    }
}

extension API {
    
    internal func injectAPIKey(_ key: String? = NetworkConfig.apiKey,
                               parameters: inout [String: Any]?) {
        if parameters == nil {
            parameters = [:]
        }
        
        parameters?[Keys.apiKey] = key
    }
}

class MockAPI: API {
    
    var failable: Bool?
    
    override init(host: String) {
        super.init(host: host)
    }
    
    private func createMockPathFrom(_ path: String,
                                    httpMethod: HTTPMethod) -> String {
        
        return httpMethod.rawValue + "\(path.replacingOccurrences(of: "/", with: "-")).json"
    }

    override func request(request: Request?) {
        guard let request = request else { return }
        
        let method      = request.method
        let path        = request.path
        let mockPath    = createMockPathFrom(request.path,
                                             httpMethod: request.method)
        
        let mockRequest                 = Request(path: path,
                                                  method: request.method)
        mockRequest.errorCompletion     = request.errorCompletion
        mockRequest.successCompletion   = request.successCompletion
        
        switch method {
        case .get:
            if failable == true {
                self.networking?.fakeGET(path,
                                         response: generateFakeErrorResponse(),
                                         statusCode: 401)
            } else {
                self.networking?.fakeGET(path,
                                         fileName: mockPath,
                                         bundle: Bundle.main)
            }

        case .post:
            if failable == true {
                self.networking?.fakePOST(path,
                                         response: generateFakeErrorResponse(),
                                         statusCode: 401)
            } else {
                self.networking?.fakePOST(path,
                                          fileName: mockPath,
                                          bundle: Bundle.main)
            }
        case .put:
            if failable == true {
                self.networking?.fakePUT(path,
                                          response: generateFakeErrorResponse(),
                                          statusCode: 401)
            } else {
                self.networking?.fakePUT(path,
                                         fileName: mockPath,
                                         bundle: Bundle.main)
            }
            
        case .delete:
            if failable == true {
                self.networking?.fakeDELETE(path,
                                         response: generateFakeErrorResponse(),
                                         statusCode: 401)
            } else {
                self.networking?.fakeDELETE(path,
                                         fileName: mockPath,
                                         bundle: Bundle.main)
            }
        }
        
        super.request(request: mockRequest)
    }
    
    func generateFakeErrorResponse() -> ErrorResponse {
        
        return ErrorResponse(statusCode: "401",
                             error: "Unauthorized")
    }
}

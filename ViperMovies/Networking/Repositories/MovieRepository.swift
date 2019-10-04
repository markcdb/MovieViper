//
//  MovieRepository.swift
//  Movie
//
//  Created by Mark Christian Buot on 10/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

class MovieRepository: Repository<MovieDetails> {
    
    typealias SingleC   = ((MovieDetails?, Error?) -> ())
    typealias ArrayC    = (([MovieDetails]?, Error?) -> ())
    
    override func getList<U: Codable>(params: U?,
                                      completion: @escaping ArrayC) {
        guard let param = params else { return }

        super.getList(params: params,
                      completion: completion)
        
        let path = Paths.nowPlaying
        
        let request = Request(path: path,
                              method: .get)
        
        request.createParametersFrom(param)
        
        createSuccessAndFail(request,
                             completion: completion)
    }
    
    override func get<U: LosslessStringConvertible>(params: U?,
                                                    completion: @escaping SingleC) {
        guard let param = params else { return }
        
        super.get(params: params,
                  completion: completion)
        
        let path = Paths.movie.replacingOccurrences(of: URLParameters.id,
                                                    with: String(param))
        
        let request = Request(path: path,
                              method: .get)
        
        createSuccessAndFail(request,
                             completion: completion)
    }
    
    func getSimilarFrom(id: String?,
                        withSorter sorter: MovieSorter?,
                        completion: @escaping ArrayC) {
        guard let id = id else { return }
        
        let path = Paths.similar.replacingOccurrences(of: URLParameters.id,
                                                      with: id)
        
        let request = Request(path: path,
                              method: .get)
        
        request.createParametersFrom(sorter)

        createSuccessAndFail(request,
                             completion: completion)
    }
}

class MockMovieRepository: MovieRepository {
    
    internal var failable: Bool = false {
        didSet {
            (api as? MockAPI)?.failable = failable
        }
    }
    
    override init() {
        super.init()
        api = MockAPI(host: NetworkConfig.baseUrl)
    }
}

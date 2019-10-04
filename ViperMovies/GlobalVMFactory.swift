//
//  GlobalFactory.swift
//  Movie
//
//  Created by Mark Christian Buot on 03/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

typealias VMFactory = GlobalVMFactory

class GlobalVMFactory {
    
    static func createMovieListVM(repository: MovieRepository? = nil,
                                  delegate: BaseVMDelegate?) -> MovieListViewModel {
        let viewModel = MovieListViewModel(delegate: delegate,
                                           repository: repository ?? MovieRepository())
        
        return viewModel
    }
    
    static func createMovieDetailsVM(repository: MovieRepository? = nil,
                                     delegate: BaseVMDelegate?) -> MovieDetailsViewModel {
        
        let viewModel = MovieDetailsViewModel(delegate: delegate,
                                              repository: repository ?? MovieRepository())
        
        return viewModel
    }
    
    static func createWebVM(repository: MovieRepository? = nil,
                            delegate: BaseVMDelegate?) -> WebViewModel {
        
        let viewModel = WebViewModel(delegate: delegate,
                                     repository: repository ?? MovieRepository())
        
        return viewModel
    }
}

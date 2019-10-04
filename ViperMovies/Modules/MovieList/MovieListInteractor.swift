//
//  MovieListInteractor.swift
//  ViperMovies
//
//  Created by user on 4/10/19.
//  Copyright © 2019 gojek. All rights reserved.
//

import Foundation


protocol MovieListInteractorDelegate: class {
    
    var state: ViewState? { get set }
    func didFailedFetchMovies(_ error: String?)
    func didReceivedFetchMovies(_ movies: [MovieDetails]?)
}

class MovieListInteractor: BaseInteractor<MovieRepository> {
    
    internal weak var interactorDelegate: MovieListInteractorDelegate?
    internal var movieSorter: MovieSorter?

    override init(repository: MovieRepository) {
        super.init(repository: repository)
        
        movieSorter = MovieSorter.defaultWithReleaseDate()
    }
    
    override func request() {
        super.request()
        
        interactorDelegate?.state = .loading(nil)
        
        repository?.getList(params: movieSorter,
                            completion: {[weak self] (movies, error) in
                                guard let self = self else {
                                    return
                                }
                                
                                if error != nil {
                                    self.interactorDelegate?.state = .error(nil)
                                    self.interactorDelegate?.didFailedFetchMovies(nil)
                                    return
                                }
                                
                                let page = (self.movieSorter?.page ?? 0) + 1
                                self.movieSorter?.page = page
                                
                                self.interactorDelegate?.state = .success(nil)
                                self.interactorDelegate?.didReceivedFetchMovies(movies)
        })
    }
}

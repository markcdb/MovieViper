//
//  MovieDetailsInteractor.swift
//  ViperMovies
//
//  Created by user on 4/10/19.
//  Copyright © 2019 gojek. All rights reserved.
//

import Foundation

protocol MovieDetailsInteractorDelegate: class {
    
    var state: ViewState? { get set }
    
    func didFailedFetchMovie(_ error: String?)
    func didFailedFetchMovies(_ error: String?)
    func didReceivedFetchMovie(_ movie: MovieDetails?)
    func didReceivedFetchMovies(_ movies: [MovieDetails]?)
}

class MovieDetailsInteractor: BaseInteractor<MovieRepository> {
    internal var id: Int?

    internal var movieSorter: MovieSorter?
    
    internal weak var interactorDelegate: MovieDetailsInteractorDelegate?
    
    override init(repository: MovieRepository) {
        super.init(repository: repository)
        
        movieSorter = MovieSorter.defaultWithReleaseDate()
    }
 
    override func request() {
        super.request()
        
        interactorDelegate?.state = .loading(nil)
        
        repository?.get(params: id,
                        completion: {[weak self] (movie, error) in
                            guard let self = self else { return }
                            
                            if error != nil {
                                self.interactorDelegate?.state = .error(nil)
                                return
                            }
                            
                            self.interactorDelegate?.didReceivedFetchMovie(movie)
                            self.interactorDelegate?.state = .success(nil)
        })
    }
    
    internal func getSimilar(completion: @escaping (() -> Void)) {
        
        repository?.getSimilarFrom(id: String(id ?? 0),
                                   withSorter: movieSorter,
                                   completion: {[weak self] (movies, error) in
                                    guard let self = self else { return }
                                    
                                    if error != nil {
                                        if error?.localizedDescription == Titles.pagingLimit {
                                            self.movieSorter?.isLastPage = true
                                        }
                                        
                                        completion()
                                        return
                                    }
                                    
                                    
                                    self.interactorDelegate?.didReceivedFetchMovies(movies)
                                    completion()
                                    
                                    let page = (self.movieSorter?.page ?? 0) + 1
                                    self.movieSorter?.page = page
        })
    }
    
    /*
    override func retry() {
        super.retry()
        
        resetPage()
        request()
    }
    
    internal func resetPage() {
        
        movieSorter?.page = 1
        movies.removeAll()
    }
    */
}

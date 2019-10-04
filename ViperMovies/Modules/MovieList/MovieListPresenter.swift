//
//  MovieListPresenter.swift
//  ViperMovies
//
//  Created by user on 4/10/19.
//  Copyright © 2019 gojek. All rights reserved.
//

import Foundation

protocol MovieListPresenterDelegate: class {
    
    func didUpdatePresenterWithState(_ state: ViewState)
}

class MovieListPresenter: BasePresenter<MovieListInteractor>, MovieListPresenterProtocol {
    var movieSorter: MovieSorter?

    var movies: [MovieDetails] = [] {
        didSet {
            guard let state = state else { return }
            delegate?.didUpdatePresenterWithState(state)
        }
    }

    var router: MovieListRouter?
    var state: ViewState?
    var delegate: MovieListPresenterDelegate?
    
    init(interactor: MovieListInteractor,
         router: MovieListRouter) {
        super.init(interactor: interactor)
        self.router     = router
    }
    
    internal func resetPage() {
        
        interactor?.movieSorter?.page = 1
        movies.removeAll()
    }
    
    func pushFromRow(_ row: Int) {
        
        if let id = getMovieIdAt(row) {
            router?.pushToDetailsWithId(id)
        }
    }
  
    func isLastPage() -> Bool {
        return interactor?.movieSorter?.isLastPage ?? false
    }
}

extension MovieListPresenter: MovieListInteractorDelegate {
    
    func didFailedFetchMovies(_ error: String?) {
        guard let state = state else { return }
        delegate?.didUpdatePresenterWithState(state)
    }
    
    func didReceivedFetchMovies(_ movies: [MovieDetails]?) {
        guard let movies = movies else { return }
        self.movies.append(contentsOf: movies)
    }
}

//
//  MovieDetailsPresenter.swift
//  ViperMovies
//
//  Created by user on 4/10/19.
//  Copyright © 2019 gojek. All rights reserved.
//

import Foundation

protocol MovieDetailsPresenterDelegate: class {
    
    func didUpdatePresenterWithState(_ state: ViewState)
}

class MovieDetailsPresenter: BasePresenter<MovieDetailsInteractor>, MovieListPresenterProtocol, MovieDetailsPresenterProtocol {
    
    var movie: MovieDetails? {
        didSet {
            guard let state = state else { return }
            delegate?.didUpdatePresenterWithState(state)
        }
    }
    
    var movieSorter: MovieSorter?
    
    var movies: [MovieDetails] = []
    
    var router: MovieDetailsRouter?
    var state: ViewState?
    var delegate: MovieDetailsPresenterDelegate?
    
    init(interactor: MovieDetailsInteractor,
         router: MovieDetailsRouter) {
        super.init(interactor: interactor)
        self.router     = router
    }
    
    internal func resetPage() {
        
        interactor?.movieSorter?.page = 1
        movies.removeAll()
    }
    
    internal func getSimilar(completion: @escaping (() -> Void)) {
        interactor?.getSimilar(completion: completion)
    }
    
    func isLastPage() -> Bool {
        return interactor?.movieSorter?.isLastPage ?? false
    }
    
    func pushWithId(_ id: Int) {
        router?.pushToDetailsWithId(id)
    }
}

extension MovieDetailsPresenter: MovieDetailsInteractorDelegate {
    func didFailedFetchMovie(_ error: String?) {
        guard let state = state else { return }
        delegate?.didUpdatePresenterWithState(state)
    }
    
    func didFailedFetchMovies(_ error: String?) {
        guard let state = state else { return }
        delegate?.didUpdatePresenterWithState(state)
    }
    
    func didReceivedFetchMovie(_ movie: MovieDetails?) {
        guard let movie = movie else { return }
        self.movie = movie
    }
    
    func didReceivedFetchMovies(_ movies: [MovieDetails]?) {
        guard let movies = movies else { return }
        self.movies.append(contentsOf: movies)
    }
}

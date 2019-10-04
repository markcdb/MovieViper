//
//  MovieViewModel.swift
//  Movie
//
//  Created by Mark Christian Buot on 10/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieListViewModel: BaseVMRepo<MovieRepository>, MovieListPresenter {
    internal var movieSorter: MovieSorter?
    
    internal var movies: [MovieDetails] = []
    
    
    override init(delegate: BaseVMDelegate?,
                  repository: MovieRepository) {
        super.init(delegate: delegate,
                   repository: repository)
        
        movieSorter = MovieSorter.defaultWithReleaseDate()
    }
    
    override func startBinding() {
        super.startBinding()
    }
    
    override func request() {
        super.request()
        
        viewState.accept(.loading(nil))
        
        repository?.getList(params: movieSorter,
                            completion: {[weak self] (movies, error) in
                                guard let self = self else {
                                    return
                                }
                                
                                if error != nil {
                                    self.viewState.accept(.error(nil))
                                    return
                                }
                                
                                let page = (self.movieSorter?.page ?? 0) + 1
                                self.movieSorter?.page = page
                                
                                self.movies.append(contentsOf: movies ?? [])
                                
                                self.viewState.accept(.success(nil))
        })
    }
    
    internal func resetPage() {
        
        movieSorter?.page = 1
        movies.removeAll()
    }
    
    override func retry() {
        super.retry()
        
        resetPage()
        request()
    }
}

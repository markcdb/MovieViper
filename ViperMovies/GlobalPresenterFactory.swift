//
//  GlobalFactory.swift
//  Movie
//
//  Created by Mark Christian Buot on 03/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import UIKit

typealias PresenterFactory = GlobalPresenterFactory

class GlobalPresenterFactory {
    
    static func createMovieListPresenterFromVC(_ vc: MovieListViewController,
                                               repository: MovieRepository? = nil) -> MovieListPresenter? {
        let router    = MovieListRouter(navigationController: vc.navigationController)
        let interactor = MovieListInteractor(repository: repository ?? MovieRepository())
        let presenter = MovieListPresenter(interactor: interactor,
                                           router: router)
        presenter.delegate = vc
        interactor.interactorDelegate = presenter
        return presenter
    }
    
    static func createMovieDetailsPresenterFromVC(_ vc: MovieDetailsViewController,
                                                  id: Int,
                                                  repository: MovieRepository? = nil,
                                                  nv: UINavigationController? = nil) -> MovieDetailsPresenter? {
        let router     = MovieDetailsRouter(navigationController: nv)
        let interactor = MovieDetailsInteractor(repository: repository ?? MovieRepository())
        interactor.id  = id
        let presenter  = MovieDetailsPresenter(interactor: interactor,
                                               router: router)
        presenter.delegate = vc
        interactor.interactorDelegate = presenter
        return presenter
    }
    
    static func createWebViewPresenterFromVC(_ vc: WebViewController) -> WebViewPresenter? {
       
        let interactor = MovieDetailsInteractor(repository: MovieRepository())
        let presenter = WebViewPresenter(interactor: interactor)
        return presenter
    }
}

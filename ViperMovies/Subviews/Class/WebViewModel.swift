//
//  WebViewModel.swift
//  Movie
//
//  Created by Mark Christian Buot on 14/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class WebViewPresenter: BasePresenter<MovieDetailsInteractor> {

    var urlString: String?
    
    override init(interactor: MovieDetailsInteractor?) {
        super.init(interactor: interactor)
        
    }
}

//
//  MovieListRouter.swift
//  ViperMovies
//
//  Created by user on 4/10/19.
//  Copyright © 2019 gojek. All rights reserved.
//

import Foundation
import UIKit

class MovieListRouter {
    
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func pushToDetailsWithId(_ id: Int) {
        if let nv = navigationController,
            let vc = GlobalVCFactory.createMovieDetailsWithId(id,
                                                             nv: nv) {
            navigationController?.pushViewController(vc,
                                                     animated: true)
        }
    }
}

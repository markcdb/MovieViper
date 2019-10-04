//
//  WebViewModel.swift
//  Movie
//
//  Created by Mark Christian Buot on 14/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class WebViewModel: BaseVMRepo<MovieRepository> {

    var urlString: String?
    
    override init(delegate: BaseVMDelegate?,
                  repository: MovieRepository) {
        super.init(delegate: delegate,
                   repository: repository)
    }
}

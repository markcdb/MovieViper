//
//  BaseInteractorRepo.swift
//  ViperMovies
//
//  Created by user on 4/10/19.
//  Copyright © 2019 gojek. All rights reserved.
//

import Foundation

protocol BaseInteractorRequestProtocol {
    
    func request()
    func retry()
}

class BaseInteractor<T: RepositoryProtocol>: BaseInteractorRequestProtocol {
    
    var repository: T?
    
    open func request() {}
    
    open func retry() {
        repository?.retry()
    }
    
    init(repository: T) {
        
        self.repository = repository
    }
}

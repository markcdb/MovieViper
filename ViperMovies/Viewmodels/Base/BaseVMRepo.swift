//
//  BaseVMRepo.swift
//  Movie
//
//  Created by Mark Christian Buot on 10/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

protocol BaseVMRequestProtocol {
    
    func request()
    func retry()
}

class BaseVMRepo<T: RepositoryProtocol>: BaseVM, BaseVMRequestProtocol {
    
    var repository: T?
    
    open func request() {}
    
    open func retry() {
        repository?.retry()
    }
    
    init(delegate: BaseVMDelegate?,
         repository: T) {
        super.init(delegate: delegate)
        
        self.repository = repository
    }
}

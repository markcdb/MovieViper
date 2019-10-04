//
//  BasePresenter.swift
//  ViperMovies
//
//  Created by user on 4/10/19.
//  Copyright © 2019 gojek. All rights reserved.
//

import Foundation

protocol BasePresenterRequesterProtocol {
    
    func request()
    func retry()
}

class BasePresenter<T: BaseInteractorRequestProtocol>: BasePresenterRequesterProtocol {
    
    var interactor: T?
    
    open func request() {
        interactor?.request()
    }
    
    open func retry() {
        interactor?.retry()
    }
    
    init(interactor: T?) {
        
        self.interactor = interactor
    }
}

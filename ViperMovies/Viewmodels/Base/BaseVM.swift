//
//  BaseVM.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 31/01/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseVMDelegate: class {
    
    func didUpdateModelWithState(_ viewState: ViewState)
}

class BaseVM {
    
    open var viewState: BehaviorRelay<ViewState?> = BehaviorRelay(value: nil)
    
    open weak var delegate: BaseVMDelegate?
    
    open var disposeBag: DisposeBag = DisposeBag()

    init(delegate: BaseVMDelegate?) {
        self.delegate = delegate
        startBinding()
    }
    
    internal func startBinding() {
       viewState.subscribe(onNext: {[weak self] state in
            guard let self = self else { return }
            
            if let state = state {
                self.delegate?.didUpdateModelWithState(state)
            }
        }).disposed(by: disposeBag)
    }
}

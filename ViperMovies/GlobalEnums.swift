//
//  GlobalEnums.swift
//  Movie
//
//  Created by Mark Christian Buot on 03/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

enum ViewState: Equatable {
    case loading(String?)
    case success(String?)
    case error(String?)
    
    internal func getString() -> String {
        switch self {
        case .loading(let str):
            return str ?? blank_
        case .success(let str):
            return str ?? blank_
        case .error(let str):
            return str ?? blank_
        }
    }
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        
        switch (lhs, rhs) {
        case (.loading(_), .loading(_)):
            return true
        case (.success(_), .success(_)):
            return true
        case (.error(_), .error(_)):
            return true
        default:
            return false
        }
    }
    
    static func != (lhs: ViewState, rhs: ViewState) -> Bool {
        
        switch (lhs, rhs) {
        case (.loading(_), .loading(_)):
            return false
        case (.success(_), .success(_)):
            return false
        case (.error(_), .error(_)):
            return false
        default:
            return true
        }
    }
}

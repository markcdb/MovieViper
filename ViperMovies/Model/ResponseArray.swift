//
//  TMDBArray.swift
//  Movie
//
//  Created by Mark Christian Buot on 11/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

struct ResponseArray<T: Codable>: Codable {
    
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: T?
    
    var data: Data? {
        var data: Data?
        
        if let res = results {
            data = try? JSONEncoder().encode(res)
        }
        
        return data
    }
}

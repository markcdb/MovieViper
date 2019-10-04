//
//  DateHelper.swift
//  Movie
//
//  Created by Mark Christian Buot on 12/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

extension Date {
    
    func toWordFormat() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEEE, MMMM d, yyyy"
        
        return dateFormat.string(from: self)
    }
    
    func toYearMonthDayFormat() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        
        return dateFormat.string(from: self)
    }
}

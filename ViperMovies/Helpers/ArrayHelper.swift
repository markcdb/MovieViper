//
//  ArrayHelper.swift
//  Movie
//
//  Created by Mark Christian Buot on 03/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    internal func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension Array where Element: Comparable {
    
   
    func maxLog() -> Element? {
       return getMaxLog(self)
    }
    
    //0(log n) implementation of array.max()
    //reading the description states that max()'s complexity is 0(n)
    private func getMaxLog(_ array: Array) -> Element? {
        guard array.count > 1 else { return array.first }
        
        let left  = array[0 ..< array.count / 2]
        let right = array[array.count / 2 ..< array.count]
        
        if let l = left.last,
            let r = right.first,
            l > r {
            
            return getMaxLog(Array(left))
        }
        
        return getMaxLog(Array(right))
    }
}

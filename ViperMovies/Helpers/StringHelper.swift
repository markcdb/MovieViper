//
//  StringHelper.swift
//  Movie
//
//  Created by Mark Christian Buot on 03/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import UIKit

extension String {
    internal func isEnglishCharactersOnly() -> Bool {
        let regexStatement = "[A-Za-z .,'-]*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regexStatement)
        return predicate.evaluate(with: self)
    }
    
    internal func containsOnlyValidCharacters() -> Bool {
        let regexStatement = "[\\p{L}\\s .,'-]*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regexStatement)
        return predicate.evaluate(with: self)
    }
    
    internal func containsOnlyLetters() -> Bool {
        let regexStatement = "[\\p{L} ]*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regexStatement)
        return predicate.evaluate(with: self)
    }
    
    internal func containsALetter() -> Bool {
        let range = self.rangeOfCharacter(from: CharacterSet.letters)
        if range != nil {
            return true
        }
        else {
            return false
        }
    }
    
    internal func containsANumber() -> Bool {
        let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits)
        if range != nil {
            return true
        }
        else {
            return false
        }
    }
    
    internal func isValidEmail() -> Bool {
        let regexStatement = "[\\p{L}0-9._%+-]+@[\\p{L}0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regexStatement)
        return predicate.evaluate(with: self) && !self.contains("..")
    }
    
    internal func containsAlphaNumericOnly() -> Bool {
        let regexStatement = "[^\\p{L}0-9]"
        return self.range(of: regexStatement, options: .regularExpression) == nil && self != blank_
    }
    
    internal func toDate() -> Date? {
        if self == blank_ { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.date(from: self)
    }
    
    internal func index(of string: String) -> Int? {
        guard let index = range(of: string)?.lowerBound else { return nil }
        return distance(from: startIndex, to: index)
    }
    
    internal func length() -> Int? {
        return distance(from: startIndex, to: endIndex)
    }
    
    internal func toURL() -> URL? {
        return URL(string: self)
    }
    
    internal func urlFromString() -> URL? {
        let type     = NSTextCheckingResult.CheckingType.link.rawValue
        
        let detector = try! NSDataDetector(types: type)
        
        var toUrl: URL?
        
        detector.enumerateMatches(in: self,
                                  options: [],
                                  range: NSMakeRange(0, self.count)) { result, _, _ in
            
            guard let result = result,
                let url = result.url  else { return }
            
            toUrl = url
        }
        
        return toUrl ?? nil
    }

    static func generateAlphabetArray() -> [String] {
        let aScalars = "a".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value
        
        var letters: [String] = (0..<26).map {
            i in String(UnicodeScalar(aCode + i)!).uppercased()
        }
        
        letters.append("#")
        
        return letters
    }
    
    internal func getFormattedDate(_ dateString: String) -> String? {
        guard let date = dateString.toDate() else { return nil }
        
        return date.toWordFormat()
    }
    
    internal func getImageUrlStringWith(_ size: CGFloat?) -> String? {
        //"w92", "w154", "w185", "w342", "w500", "w780", or "original"
        var stringSize = "original"
        
        var widthSize: CGFloat?
        
        if let size = size {
            //Size lower than 200 will cause the api to return error
            widthSize    = size < 200 ? 500 : 780
            
            stringSize   = "w\(Int(widthSize ?? 0))"
        }
        
        let url        = NetworkConfig.baseImageUrl.replacingOccurrences(of: URLParameters.width,
                                                                         with: stringSize)
        
        return url.appending(self)
    }
}

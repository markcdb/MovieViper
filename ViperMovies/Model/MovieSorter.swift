//
//  Sorter.swift
//  Movie
//
//  Created by Mark Christian Buot on 12/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

struct MovieSorter: Codable {
    
    var language: String?
    var region: String?
    var sort_by: String?
    var certification_country: String?
    var certification: String?
    var include_adult: Bool?
    var include_video: Bool?
    var page: Int?
    var primary_release_year: Int?
    var primary_release_date: String?
    var with_cast: String?
    var with_crew: String?
    var with_companies: String?
    var with_genres: String?
    var with_keywords: String?
    var with_people: String?
    var year: Int?
    var without_genres: String?
    var with_release_type: String?
    var with_original_language: String?
    var without_keywords: String?
    var isLastPage: Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case language               = "language"
        case region                 = "region"
        case sort_by                = "sort_by"
        case certification_country  = "certification_country"
        case certification          = "certification"
        case include_adult          = "include_adult"
        case include_video          = "include_video"
        case page                   = "page"
        case primary_release_year   = "primary_release_year"
        case primary_release_date   = "primary_release_date.lte"
        case with_cast              = "with_cast"
        case with_crew              = "with_crew"
        case with_companies         = "with_companies"
        case with_genres            = "with_genres"
        case with_keywords          = "with_keywords"
        case with_people            = "with_people"
        case year                   = "year"
        case without_genres         = "without_genres"
        case with_release_type      = "with_release_type"
        case with_original_language = "with_original_language"
        case without_keywords       = "without_keywords"
    }
    
    static func defaultWithReleaseDate() -> MovieSorter {
       
        
        return MovieSorter(language: nil,
                           region: nil,
                           sort_by: "primary_release_date.desc",
                           certification_country: nil,
                           certification: nil,
                           include_adult: nil,
                           include_video: nil,
                           page: 1,
                           primary_release_year: nil,
                           primary_release_date: Date().toYearMonthDayFormat(),
                           with_cast: nil,
                           with_crew: nil,
                           with_companies: nil,
                           with_genres: nil,
                           with_keywords: nil,
                           with_people: nil,
                           year: nil,
                           without_genres: nil,
                           with_release_type: nil,
                           with_original_language: nil,
                           without_keywords: nil,
                           isLastPage: nil)
    }
}

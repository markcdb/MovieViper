//
//  MovieDetails.swift
//  Movie
//
//  Created by Mark Christian Buot on 10/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

struct MovieDetails: Codable {
    
    var id: Int?
    var vote_count: Int?
    var video: Bool?
    var vote_average: Double?
    var title: String?
    var popularity: Double?
    var poster_path: String?
    var original_language: String?
    var original_title: String?
    var genre_ids: [Int]?
    var backdrop_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    var belongs_to_collection: MovieCollection?
    var budget: Int?
    var genres: [Genre]?
    var homepage: String?
    var imdb_id: String?
    var production_companies: [Company]?
    var revenue: Int?
    var runtime: Int?
    var spoken_languages: [Language]?
    var status: String?
    var tagline: String?
    
    static func getIsoLanguageStringFrom(_ languages: [Language]) -> [String] {
        
        return languages.compactMap({ $0.iso_639_1 ?? blank_ })
    }
    
    static func getGenreNameStringFrom(_ genres: [Genre]) -> [String] {
        
        return genres.compactMap({ $0.name ?? blank_ })
    }
    
    static func getCompanyNameStringFrom(_ companies: [Company]) -> [String] {
        
        return companies.compactMap({ $0.name ?? blank_ })
    }
}

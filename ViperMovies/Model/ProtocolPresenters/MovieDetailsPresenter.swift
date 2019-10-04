//
//  BaseMovieDetails.swift
//  Movie
//
//  Created by Mark Christian Buot on 12/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

protocol MovieDetailsPresenter {
    var movie: MovieDetails? { get set }

    func getMovieId() -> Int?
    func getMovieVoteCount() -> Int?
    func getMovieVideo() -> Bool?
    func getMovieVoteAverage() -> Double?
    func getMovieTitle() -> String?
    func getMoviePopularity() -> Double?
    func getMoviePosterPath() -> String?
    func getOriginalLanguage() -> String?
    func getOriginalTitle() -> String?
    func getGenreIds() -> [Int]?
    func getBackdropPath() -> String?
    func getAdult() -> Bool?
    func getOverview() -> String?
    func getReleaseDate() -> String?
    func getBelongsToCollection() -> MovieCollection?
    func getBudget() -> Int?
    func getGenre() -> [Genre]?
    func getGenreString() -> String?
    func getHomepage() -> String?
    func getImdbId() -> String?
    func getProductionCompanies() -> [Company]?
    func getRevenue() -> Int?
    func getRuntime() -> Int?
    func getRuntimeString() -> String
    func getSpokenLanguage() -> [Language]?
    func getSpokenLanguageString() -> String?
    func getStatus() -> String?
    func getTagline() -> String?
}

extension MovieDetailsPresenter {
    func getMovieId() -> Int? {
        
        return movie?.id
    }
    
    func getMovieVoteCount() -> Int? {
        
        return movie?.vote_count
    }
    
    func getMovieVideo() -> Bool? {
        
        return movie?.video
    }
    
    func getMovieVoteAverage() -> Double? {
        
        return movie?.vote_average
    }
    
    func getMovieTitle() -> String? {
        
        return movie?.title
    }
    
    func getMoviePopularity() -> Double? {
        
        return movie?.popularity
    }
    
    func getMoviePosterPath() -> String? {
        
        return movie?.poster_path
    }
    
    func getOriginalLanguage() -> String? {
        
        return movie?.original_language
    }
    
    func getOriginalTitle() -> String? {
        
        return movie?.original_title
    }
    
    func getGenreIds() -> [Int]? {
        
        return movie?.genre_ids
    }
    
    func getBackdropPath() -> String? {
        
        return movie?.backdrop_path
    }
    
    func getAdult() -> Bool? {
        
        return movie?.adult
    }
    
    func getOverview() -> String? {
        
        return movie?.overview
    }
    
    func getReleaseDate() -> String? {
        
        return movie?.release_date
    }
    
    func getBelongsToCollection() -> MovieCollection? {
        
        return movie?.belongs_to_collection
    }
    
    func getBudget() -> Int? {
        
        return movie?.budget
    }
    
    func getGenre() -> [Genre]? {
        
        return movie?.genres
    }
    
    func getGenreString() -> String? {
        
        let array = movie?.genres?.compactMap({ $0.name ?? blank_ })
        
        return array?.joined(separator: ", ")
    }
    
    func getHomepage() -> String? {
        
        return movie?.homepage
    }
    
    func getImdbId() -> String? {
        
        return movie?.imdb_id
    }
    
    func getProductionCompanies() -> [Company]? {
        
        return movie?.production_companies
    }
    
    func getRevenue() -> Int? {
        
        return movie?.revenue
    }
    
    func getRuntime() -> Int? {
        
        return movie?.runtime
    }
    
    func getRuntimeString() -> String {
        
        return "\(getRuntime() ?? 0) minutes"
    }
    
    func getSpokenLanguage() -> [Language]? {
        
        return movie?.spoken_languages
    }
    
    func getSpokenLanguageString() -> String? {
        
        let array = movie?.spoken_languages?.compactMap({ $0.name ?? blank_ })
        
        return array?.joined(separator: ", ")
    }
    
    func getStatus() -> String? {
        
        return movie?.status
    }
    
    func getTagline() -> String? {
        
        return movie?.tagline
    }
}

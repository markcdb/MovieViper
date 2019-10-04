//
//  BaseMovie.swift
//  Movie
//
//  Created by Mark Christian Buot on 12/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

protocol MovieListPresenter {
    
    var movies: [MovieDetails] { get set }
    var movieSorter: MovieSorter? { get set }

    func getMovieCount() -> Int
    func getMovieIdAt(_ index: Int) -> Int?
    func getMovieVoteCountAt(_ index: Int) -> Int?
    func getMovieVideoAt(_ index: Int) -> Bool?
    func getMovieVoteAverageAt(_ index: Int) -> Double?
    func getMovieTitleAt(_ index: Int) -> String?
    func getMoviePopularityAt(_ index: Int) -> Double?
    func getMoviePosterPathAt(_ index: Int) -> String?
    func getOriginalLanguageAt(_ index: Int) -> String?
    func getOriginalTitleAt(_ index: Int) -> String?
    func getGenreIdsAt(_ index: Int) -> [Int]?
    func getBackdropPathAt(_ index: Int) -> String?
    func getAdultAt(_ index: Int) -> Bool?
    func getOverviewAt(_ index: Int) -> String?
    func getReleaseDateAt(_ index: Int) -> String?
    func getBelongsToCollectionAt(_ index: Int) -> MovieCollection?
    func getBudgetAt(_ index: Int) -> Int?
    func getGenreAt(_ index: Int) -> [Genre]?
    func getHomepageAt(_ index: Int) -> String?
    func getImdbIdAt(_ index: Int) -> String?
    func getProductionCompaniesAt(_ index: Int) -> [Company]?
    func getRevenueAt(_ index: Int) -> Int?
    func getRuntimeAt(_ index: Int) -> Int?
    func getSpokenLanguageAt(_ index: Int) -> [Language]?
    func getStatusAt(_ index: Int) -> String?
    func getTaglineAt(_ index: Int) -> String?
    func getIsoLanguageStringAt(_ index: Int) -> [String]
    func getGenreNameStringAt(_ index: Int) -> [String]
    func getCompanyNameStringAt(_ index: Int) -> [String]
}

extension MovieListPresenter {
    
    func getMovieCount() -> Int {
        
        return movies.count
    }
    
    func getMovieIdAt(_ index: Int) -> Int? {
        guard index < movies.count else { return nil }
        
        return movies[index].id
    }
    
    func getMovieVoteCountAt(_ index: Int) -> Int? {
        guard index < movies.count else { return nil }
        
        return movies[index].vote_count
    }
    
    func getMovieVideoAt(_ index: Int) -> Bool? {
        guard index < movies.count else { return nil }
        
        return movies[index].video
    }
    
    func getMovieVoteAverageAt(_ index: Int) -> Double? {
        guard index < movies.count else { return nil }
        
        return movies[index].vote_average
    }
    
    func getMovieTitleAt(_ index: Int) -> String? {
        guard index < movies.count else { return nil }
        
        return movies[index].title
    }
    
    func getMoviePopularityAt(_ index: Int) -> Double? {
        guard index < movies.count else { return nil }
        
        return movies[index].popularity
    }
    
    func getMoviePosterPathAt(_ index: Int) -> String? {
        guard index < movies.count else { return nil }
        
        return movies[index].poster_path
    }
    
    func getOriginalLanguageAt(_ index: Int) -> String? {
        guard index < movies.count else { return nil }
        
        return movies[index].original_language
    }
    
    func getOriginalTitleAt(_ index: Int) -> String? {
        guard index < movies.count else { return nil }
        
        return movies[index].original_title
    }
    
    func getGenreIdsAt(_ index: Int) -> [Int]? {
        guard index < movies.count else { return nil }
        
        return movies[index].genre_ids
    }
    
    func getBackdropPathAt(_ index: Int) -> String? {
        guard index < movies.count else { return nil }
        
        return movies[index].backdrop_path
    }
    
    func getAdultAt(_ index: Int) -> Bool? {
        guard index < movies.count else { return nil }
        
        return movies[index].adult
    }
    
    func getOverviewAt(_ index: Int) -> String? {
        guard index < movies.count else { return nil }
        
        return movies[index].overview
    }
    
    func getReleaseDateAt(_ index: Int) -> String? {
        guard index < movies.count else { return nil }
        
        return movies[index].release_date
    }
    
    func getBelongsToCollectionAt(_ index: Int) -> MovieCollection? {
        guard index < movies.count else { return nil }
        
        return movies[index].belongs_to_collection
    }
    
    func getBudgetAt(_ index: Int) -> Int? {
        guard index < movies.count else { return nil }
        
        return movies[index].budget
    }
    
    func getGenreAt(_ index: Int) -> [Genre]? {
        guard index < movies.count else { return nil }
        
        return movies[index].genres
    }
    
    func getHomepageAt(_ index: Int) -> String? {
        guard index < movies.count else { return nil }
        
        return movies[index].homepage
    }
    
    func getImdbIdAt(_ index: Int) -> String? {
        guard index < movies.count else { return nil }
        
        return movies[index].imdb_id
    }
    
    func getProductionCompaniesAt(_ index: Int) -> [Company]? {
        guard index < movies.count else { return nil }
        
        return movies[index].production_companies
    }
    
    func getRevenueAt(_ index: Int) -> Int? {
        guard index < movies.count else { return nil }
        
        return movies[index].revenue
    }
    
    func getRuntimeAt(_ index: Int) -> Int? {
        guard index < movies.count else { return nil }
        
        return movies[index].runtime
    }
    
    func getSpokenLanguageAt(_ index: Int) -> [Language]? {
        guard index < movies.count else { return nil }
        
        return movies[index].spoken_languages
    }
    
    func getStatusAt(_ index: Int) -> String? {
        guard index < movies.count else { return nil }
        
        return movies[index].status
    }
    
    func getTaglineAt(_ index: Int) -> String? {
        guard index < movies.count else { return nil }
        
        return movies[index].tagline
    }
    
    func getIsoLanguageStringAt(_ index: Int) -> [String] {
        guard let languages = getSpokenLanguageAt(index) else { return [] }
        
        return MovieDetails.getIsoLanguageStringFrom(languages)
    }
    
    func getGenreNameStringAt(_ index: Int) -> [String] {
        guard let genres = getGenreAt(index) else { return [] }
        
        return MovieDetails.getGenreNameStringFrom(genres)
    }
    
    func getCompanyNameStringAt(_ index: Int) -> [String] {
        guard let companies = getProductionCompaniesAt(index) else { return [] }
        
        return MovieDetails.getCompanyNameStringFrom(companies)
    }
}

//
//  Constant.swift
//  Movie
//
//  Created by Mark Christian Buot on 03/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import UIKit

let blank_ = ""

struct NetworkConfig {
    
    static let baseImageUrl = "https://image.tmdb.org/t/p/\(URLParameters.width)"
    static let baseUrl      = "https://api.themoviedb.org/3"
    static let apiKey       = "328c283cd27bd1877d9080ccb1604c91"
    static let webUrl       = "https://www.cathaycineplexes.com.sg"
}

struct Paths {
    
    static let testPath   = "XCTestConfigurationFilePath"
    static let discover   = "/discover/movie" //GET & POST
    static let nowPlaying = "/movie/now_playing"
    static let movie      = "/movie/\(URLParameters.id)" //GET, PUT & DELETE
    static let similar    = "\(Paths.movie)/similar"
}

struct Keys {
    
    static let language      = "language"
    static let statusCode    = "statusCode"
    static let message       = "message"
    static let response      = "response"
    static let venues        = "venues"
    static let error         = "error"
    static let hosts         = "hosts"
    static let hostResponses = "hostResponses"
    static let apiKey        = "api_key"
}

struct Cells {
    
    static let errorCell           = "ErrorCell"
    static let movieDetailsCell    = "MovieDetailsCell"
    static let moviePreviewCell    = "MoviePreviewCell"
    static let movieHeaderCell     = "MovieHeaderCell"
    static let movieSimilarCell    = "MovieSimilarCell"
    static let similarCell         = "SimilarCell"
    static let loaderCVCell        = "LoaderCVCell"
    static let loaderCell          = "LoaderCell"
}

struct Nibs {
    
    static let sectionHeaderView       = "SectionHeaderView"
    static let loaderView              = "LoaderView"
}

struct StoryboardIDs {
    
    static let webView             = "WebViewController"
    static let movieDetails        = "MovieDetailsViewController"
}

struct URLParameters {
    
    static let id    = "$[id]"
    static let width = "$[width]"
}

struct Titles {
    
    static let bookMovie = "Book movie"
    static let movies    = "Movies"
    static let details   = "Details"
    static let pagingLimit = "Reached end page."
}

struct Colors {
    
    static let darkGray         = UIColor.hex("ADADAD")
    static let semiDarkGray     = UIColor.hex("F0F0F0")
    static let whiteGray        = UIColor.hex("E9E9E9")
    static let lightGray        = UIColor.hex("D8D8D8")
    static let semiBlack        = UIColor.hex("4A4A4A")
    static let blueGreen        = UIColor.hex("50E3C2")
    static let descriptorGray   = UIColor.hex("A1A1A1")
    static let destructiveRed   = UIColor.hex("FE4431")
    
    static let colors           = [UIColor.hex("2ECC71"),
                                   UIColor.hex("E74C3C"),
                                   UIColor.hex("8E44AD"),
                                   UIColor.hex("D35400"),
                                   UIColor.hex("F1C40F")]
    
    static func getRandomColor() -> UIColor {
        
        return Colors.colors[Int.random(in: 0..<Colors.colors.count)]
    }
}

struct Fonts {
    
    static let helveticaNeue    = UIFont(name: "HelveticaNeue", size: 14.0)
    static let helveticaNeue16  = UIFont(name: "HelveticaNeue", size: 16.0)
    static let helveticaBold17  = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
}

struct Images {
    
    static let favorite                 = UIImage(named: "home_favourite")
    static let favorite_button          = UIImage(named: "favourite_button")
    static let favorite_button_selected = UIImage(named: "favourite_button_selected")
    static let placeholder_photo        = UIImage(named: "placeholder_photo")
}

struct Notifications {
    
    static let create = Notification.Name(rawValue: "Create")
    static let update = Notification.Name(rawValue: "Update")
    static let delete = Notification.Name(rawValue: "Delete")
    static let showKeyboard = UIResponder.keyboardWillShowNotification
    static let hideKeyboard = UIResponder.keyboardWillHideNotification
}

struct Storyboard {
    
    static let movie    = UIStoryboard(name: "Movie", bundle: nil)
}

struct Strings {
    
    static let Cancel    = "Cancel"
    static let Next      = "Next"
    static let Done      = "Done"
    static let Ok        = "Ok"
    static let mockId    = 429617
    static let pagingLimit = "com.paging.limitReached"
}

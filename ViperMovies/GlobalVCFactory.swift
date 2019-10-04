//
//  GlobalVCFactory.swift
//  Movie
//
//  Created by Mark Christian Buot on 05/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import UIKit

typealias VCFactory = GlobalVCFactory

class GlobalVCFactory {
    
    internal static func createMovieDetailsWithId(_ id: Int?) -> UIViewController? {
        let sid = StoryboardIDs.movieDetails
        
        let viewController  = Storyboard.movie.instantiateViewController(withIdentifier: sid)
        guard let vc = viewController as? MovieDetailsViewController else { return nil }
        
        let vm       = GlobalVMFactory.createMovieDetailsVM(delegate: vc)
        vm.id        = id
        vc.viewModel = vm
        
        return vc
    }
    
    internal static func createWebViewController() -> UIViewController? {
        let sid = StoryboardIDs.webView
        
        let viewController  = Storyboard.movie.instantiateViewController(withIdentifier: sid)
        guard let vc = viewController as? WebViewController else { return nil }
        
        let vm       = GlobalVMFactory.createWebVM(delegate: vc)
        vm.urlString = NetworkConfig.webUrl
        vc.viewModel = vm
        
        return vc
    }
}

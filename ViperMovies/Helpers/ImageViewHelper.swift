//
//  ImageViewHelper.swift
//  Movie
//
//  Created by Mark Christian Buot on 03/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    internal func setKFImage(with urlString: String,
                    placeholder: Placeholder? = nil,
                    shouldAnimate: Bool = true,
                    keepCurrentImageWhileLoading: Bool = false,
                    completion: CompletionHandler? = nil) {
        
        let urlStringWithSize = urlString
        
        if let url = urlStringWithSize.toURL() {
            var options: KingfisherOptionsInfo = []
            if shouldAnimate == true {
                options.append(.transition(ImageTransition.fade(0.33)))
                if keepCurrentImageWhileLoading == true {
                    options.append(.keepCurrentImageWhileLoading)
                }
            }
            
            if url != kf.webURL || image == nil {
                if let path = url.absoluteString.split(separator: "/").last {
                    let resource = ImageResource(downloadURL: url, cacheKey: String(path))
                    self.kf.setImage(with: resource,
                                     placeholder: placeholder,
                                     options: options,
                                     completionHandler: completion)
                }
            }
        }
        else {
            self.image = placeholder as? UIImage
        }
    }
    
    internal func cancelKFTask() {
        self.kf.cancelDownloadTask()
    }
}

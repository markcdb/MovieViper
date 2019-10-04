//
//  SimilarCell.swift
//  Movie
//
//  Created by Mark Christian Buot on 18/08/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class SimilarCell: BaseCollectionCell {
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var title: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}


//MARK: - Custom methods
extension SimilarCell {
    
    internal func setMovieImage(posterUrl: String?) {
        self.imageView?.image           = nil
        
        if let posterUrl = posterUrl {
            setImageFrom(posterUrl,
                         imageView: &imageView)
        }
    }
}

//
//  MovieHeaderCell.swift
//  Movie
//
//  Created by Mark Christian Buot on 14/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class MovieHeaderCell: BaseCell {

    @IBOutlet weak var backdropImage: UIImageView?
    @IBOutlet weak var posterImage: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImage?.setShadow()
        backdropImage?.backgroundColor = Colors.getRandomColor()
        posterImage?.backgroundColor   = Colors.getRandomColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//MARK: - Custom methods
extension MovieHeaderCell {
   
    internal func setMovieImage(_ backdropUrl: String?,
                                posterUrl: String?) {
        self.posterImage?.image             = nil
        self.backdropImage?.image           = nil
        
        if let backdropUrl = backdropUrl {
            setImageFrom(backdropUrl,
                         imageView: &backdropImage)
        }
        
        if let posterUrl = posterUrl {
            setImageFrom(posterUrl,
                         imageView: &posterImage)
        }
    }
}

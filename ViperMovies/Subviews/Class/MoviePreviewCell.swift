//
//  MoviePreviewCell.swift
//  Movie
//
//  Created by Mark Christian Buot on 12/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class MoviePreviewCell: BaseCell {

    @IBOutlet weak var containerView: UIView?
    @IBOutlet weak var posterImage: UIImageView?
    @IBOutlet weak var backdropImage: UIImageView?
    @IBOutlet weak var blurView: UIVisualEffectView?
    @IBOutlet weak var labelContainer: UIView?
    @IBOutlet weak var subtitleDescription: BaseLabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.blurView?.isHidden             = true
        self.subtitleDescription?.textColor = Colors.darkGray
        self.titleLabel?.textColor          = Colors.darkGray
        self.subTitleLabel?.textColor       = Colors.darkGray
        self.titleLabel?.alpha              = 1
        self.subTitleLabel?.alpha           = 1
        self.posterImage?.backgroundColor   = Colors.getRandomColor()
        self.backdropImage?.isHidden        = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = posterImage?.backgroundColor
        super.setSelected(selected, animated: animated)
        
        if selected {
            posterImage?.backgroundColor = color
        }
    }
}

//MARK: - Custom methods
extension MoviePreviewCell {
    
    internal func setMovieImage(_ backdropUrl: String?,
                                posterUrl: String?) {
        self.posterImage?.image             = nil
        self.backdropImage?.image           = nil
        
        if let posterUrl = posterUrl {
            setImageFrom(posterUrl,
                         imageView: &posterImage)
        }
    }
}

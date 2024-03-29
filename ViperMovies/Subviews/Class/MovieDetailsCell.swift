//
//  MovieDetailsCell.swift
//  Movie
//
//  Created by Mark Christian Buot on 14/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class MovieDetailsCell: BaseCell {

    @IBOutlet weak var sypnosisLabel: BaseLabel?
    @IBOutlet weak var genresLabel: BaseLabel?
    @IBOutlet weak var languagesLabel: BaseLabel?
    @IBOutlet weak var durationLabel: BaseLabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

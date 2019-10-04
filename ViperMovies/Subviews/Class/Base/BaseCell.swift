//
//  BaseTableviewCell.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 02/02/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class BaseCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: BaseLabel?
    @IBOutlet weak var subTitleLabel: BaseLabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    internal func setImageFrom(_ urlString: String,
                               imageView: inout UIImageView?,
                               completion: CompletionHandler? = nil) {
        
        imageView?.setKFImage(with: urlString,
                              placeholder: nil,
                              shouldAnimate: true,
                              keepCurrentImageWhileLoading: false,
                              completion: completion)
    }
    
    internal func setWith(title: String,
                      subTitle: String) {
        
        titleLabel?.text    = title
        subTitleLabel?.text = subTitle
    }
}

class BaseCollectionCell: UICollectionViewCell {
    
    internal func setImageFrom(_ urlString: String,
                               imageView: inout UIImageView?,
                               completion: CompletionHandler? = nil) {
        
        imageView?.setKFImage(with: urlString,
                              placeholder: nil,
                              shouldAnimate: true,
                              keepCurrentImageWhileLoading: false,
                              completion: completion)
    }
}

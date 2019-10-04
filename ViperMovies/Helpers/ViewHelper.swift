//
//  ViewHelper.swift
//  Movie
//
//  Created by Mark Christian Buot on 04/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 2.5
        self.layer.shadowOpacity = 0.08
    }
}

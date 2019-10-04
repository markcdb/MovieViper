//
//  LoaderView.swift
//  Movie
//
//  Created by Mark Christian Buot on 14/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class LoaderView: BaseView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var container: UIView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
    }
    
    private func initNib() {
        initNibWithName(Nibs.loaderView)
        
        container?.frame = bounds
        container?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let container = container {
            addSubview(container)
        }
    }
}

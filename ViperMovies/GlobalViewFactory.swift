//
//  GlobalViewFactory.swift
//  Movie
//
//  Created by Mark Christian Buot on 14/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import UIKit

typealias ViewFactory = GlobalViewFactory

class GlobalViewFactory {
    
    static func createFooterLoaderView(_ tableView: UITableView?) -> LoaderView {
        
        let frame  = CGRect(x: 0,
                            y: 0,
                            width: tableView?.frame.width ?? .zero,
                            height: 50)
        
        let loader = LoaderView(frame: frame)
        return loader
    }
    
    static func createRefreshControler(_ target: Any,
                                       action: Selector) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
      
        refreshControl.addTarget(target,
                                 action: action,
                                 for: .valueChanged)
        
        return refreshControl
    }
}

//
//  WebViewController.swift
//  Movie
//
//  Created by Mark Christian Buot on 14/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class WebViewController: BaseVC<WebViewModel> {
    
    @IBOutlet weak var webView: PagesWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = Titles.bookMovie
        // Do any additional setup after loading the view.
        webView?.initView(urlString: viewModel?.urlString ?? blank_,
                         loadingYOffset: -40)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

//MARK: - Base vm delegate
extension WebViewController: BaseVMDelegate {
    
    func didUpdateModelWithState(_ viewState: ViewState) {
        
    }
}

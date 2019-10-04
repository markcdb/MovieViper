//
//  WebView.swift
//  Movie
//
//  Created by Mark Christian Buot on 14/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit
import WebKit

protocol PagesWebViewDelegate: class {
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation?)
    
    func webView(_ webView: WKWebView,
                 didFail navigation: WKNavigation?,
                 withError error: Error)
    
    func webView(_ webView: WKWebView,
                 didFailProvisionalNavigation navigation: WKNavigation?,
                 withError error: Error)
}

extension WKWebView {
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action.description == "copy:" ||
            action.description == "selectAll:" ||
            action.description == "_share:"{
            print(action.description)
            return true
        }
        
        return false
    }
}

class PagesWebView: UIView {
    
    @IBOutlet weak var contentView: UIView?
    @IBOutlet weak var webView: WKWebView?
    
    public weak var delegate: PagesWebViewDelegate?
    private var urlString: String = blank_
    private var loadingYOffset: CGFloat = 0.0
    
    private let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0,
                                                                              y: 0,
                                                                              width: 100,
                                                                              height: 100))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PagesWebView", owner: self, options: nil)
        contentView?.frame = self.frame
        addSubview(contentView ?? UIView())
    }
    
    override func layoutSubviews() {
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        contentView?.topAnchor.constraint(equalTo: topAnchor,
                                         constant: 0).isActive = true
        contentView?.bottomAnchor.constraint(equalTo: bottomAnchor,
                                            constant: safeAreaInsets.bottom).isActive = true
        contentView?.leadingAnchor.constraint(equalTo: leadingAnchor,
                                             constant: 0).isActive = true
        contentView?.trailingAnchor.constraint(equalTo: trailingAnchor,
                                              constant: 0).isActive = true
    }
    
    func initView(urlString: String, loadingYOffset: CGFloat? = nil){
        
        self.urlString = urlString
        self.loadingYOffset = loadingYOffset ?? 0.0
        
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        
        loadUrl()
    }
    
    func addActivityIndicator(loadingYOffset: CGFloat){
        activityIndicatorView.style = .gray
        activityIndicatorView.autoresizesSubviews = true
        activityIndicatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.center = CGPoint(x: contentView?.center.x ?? 0.0,
                                               y: (contentView?.center.y ?? 0.0) + loadingYOffset)
    }
    
    func removeActivityIndicator(){
        activityIndicatorView.removeFromSuperview()
    }
    
    func isvalidURL (string: String?) -> Bool {
        
        if string != nil{
            if let url = NSURL(string: string!){
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    func loadUrl() {
        if isvalidURL(string: urlString) {
            
            addActivityIndicator(loadingYOffset: loadingYOffset)
            
            let validUrlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            if let myURL = URL(string: validUrlString ?? blank_) {
                let myRequest = URLRequest(url: myURL)
                webView?.load(myRequest)
            }
        }
    }
    
    func stopLoading() {
        webView?.stopLoading()
    }
}

extension PagesWebView: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        removeActivityIndicator()
        
        delegate?.webView(webView, didFinish: navigation)
    }
    
    func webView(_ webView: WKWebView,
                 didFail navigation: WKNavigation!,
                 withError error: Error) {
        
        removeActivityIndicator()
        
        delegate?.webView(webView, didFail: navigation, withError: error)
    }
    
    func webView(_ webView: WKWebView,
                 didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: Error) {
        
        removeActivityIndicator()
       
        delegate?.webView(webView,
                          didFailProvisionalNavigation: navigation,
                          withError: error)
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else { return }
        switch navigationAction.request.url?.scheme {
        case "mailto"?:
            if UIApplication.shared.canOpenURL(url) == true {
                UIApplication.shared.open(url, options: [:]) { completed in
                    print("PagesWebView: opened \(url.absoluteString)")
                }
            }
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}

//
//  ArticleDetailVC.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/15/21.
//

import UIKit
import WebKit

class ArticleDetailVC: UIViewController {

    // Static Variables
    static let identifier = "ArticleDetailVC"
    
    // Outlets
    @IBOutlet weak var webView: WKWebView!
    
    
    // Variables
    var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.navigationDelegate = self
        webView.load(URLRequest(url: url!))
    }
    
}


extension ArticleDetailVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        GFunctions.shared.addLoader()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        GFunctions.shared.removeLoader()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        GFunctions.shared.removeLoader()
    }
    
}

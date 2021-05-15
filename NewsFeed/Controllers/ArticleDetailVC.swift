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

        // Do any additional setup after loading the view.
        webView.load(URLRequest(url: url!))
    }
    
}

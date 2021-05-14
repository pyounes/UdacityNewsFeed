//
//  NewsFeedVC.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/13/21.
//

import UIKit

class NewsFeedVC: UIViewController {
    
    // Variables
    var feeds: Feeds!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News Feed"
                
        getNewsFeeds()
        
        
    }
    
    // Custom Methods
    private func getNewsFeeds() {
        NewsFeedServices.shared.getNews(by: .usa) { (result) in
            switch result {
            case .success(let response):
                self.feeds = response
                break
            case .failure(let error):
                self.showAlert(message: error.localizedDescription, title: "Error")
                break
            }
        }
    }
    

}

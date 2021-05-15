//
//  FeedCellVM.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/14/21.
//

import UIKit

class FeedCellVM {
    let title       : String
    let subtitle    : String
    let url         : URL!
    let imageURL    : URL?
    var imageData   : Data? = nil
    
    init(title: String, subtitle: String, url: URL!, imageURL: URL?) {
        self.title      = title
        self.subtitle   = subtitle
        self.url        = url
        self.imageURL   = imageURL
    }
}

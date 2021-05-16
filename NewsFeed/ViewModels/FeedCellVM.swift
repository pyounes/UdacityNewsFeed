//
//  FeedCellVM.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/14/21.
//

import UIKit

class FeedCellVM {
    let title       : String
    let url         : String!
    let urlToImage  : String?
    let publishedAt : String!
    var imageData   : Data? = nil
    
    init(title: String, url: String!, urlToImage: String?, publishedAt: String!, imageData: Data? = nil) {
        self.title          = title
        self.url            = url
        self.urlToImage     = urlToImage
        self.publishedAt    = publishedAt
        self.imageData      = imageData
    }
}

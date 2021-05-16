//
//  Feed.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/13/21.
//

import Foundation

struct Feeds: Codable {
    let status: String!
    let totalResults: Int!
    let articles: [Article]!
}

struct Article: Codable {
    let title           : String!
    let url             : String!
    let urlToImage      : String?
    let publishedAt     : String!
    var imageData       : Data? = nil
}


struct Source: Codable {
    let id      : String!
    let name    : String!
}

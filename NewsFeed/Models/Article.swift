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
    let articles: [Article]?
}

struct Article: Codable {
    let source          : Source!
    let title           : String!
    let description     : String!
    let url             : String!
    let urlToImage      : String!
    let publishedAt     : String!
}


struct Source: Codable {
    let id      : String!
    let name    : String!
}

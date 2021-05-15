//
//  EndPoints.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/13/21.
//

import Foundation


enum EndPoints {
    private static let baseURL = "https://newsapi.org/v2"
    private static let apiKey = "36ad6164e76c4156bf1de0d5db8ccd0b"
    
    case getTopHeadlinesByCountry(Country)
    case getTopHeadlinesByQuery(String)
    
    var string: String {
        switch self {
        case .getTopHeadlinesByCountry(let country):
            return "/top-headlines?country=\(country.rawValue)&apiKey=\(EndPoints.apiKey)"
        case .getTopHeadlinesByQuery(let query):
            return "/top-headlines?q=\(query)&apiKey=\(EndPoints.apiKey)"
        }
    }
    
    // Returns the String Url and convert it to URL
    var url: URL {
        return URL(string: "\(EndPoints.baseURL)\(string)")!
    }
}


enum Country: String {
    case uae        = "ae"
    case argentina  = "ar"
    case austria    = "at"
    case australia  = "au"
    case belgium    = "be"
    case russia     = "ru"
    case usa        = "us"
}

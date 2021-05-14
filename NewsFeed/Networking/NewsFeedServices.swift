//
//  NewsFeedServices.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/13/21.
//

import Foundation

class NewsFeedServices {
    static let shared: NewsFeedServices = NewsFeedServices()
        
    /**
     - EndPoint name:
     - Method               : GET
     - Parameters     : Query parameter Country
     - Comment           :  function that fetchs NewFeed for a specific location
     - Object                :  Feeds
     */
    func getNews(by country: Country, completion: @escaping (Result<Feeds, Error>) -> Void) {
        TASKManager.taskHandler(url: EndPoints.getNewsByLocation(country).url
                                ,responseType: Feeds.self
                                ,failure: Feeds.self) { result in

            switch result {
            case .success(let apiData):
                completion(.success(apiData))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
    
    /**
     - EndPoint name:
     - Method               : Download Images
     - Parameters     :
     - Comment           : function to download images for from a specific URL
     - Object                : 
     */
//    func downloadImage(url: URL, completion: @escaping (Data?, Error?) -> Void) {
//        TASKManager.downloadHandler(url: url) { (data, error) in
//            if let error = error {
//                completion(nil, error)
//            } else {
//                if let data = data {
//                    completion(data, nil)
//                } else {
//                    completion(nil, error)
//                }
//            }
//        }
//    }
}

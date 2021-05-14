//
//  TASKManager.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/13/21.
//

import Foundation

class TASKManager {
    
    class func taskHandler<ResponseType: Decodable, FailureType: Decodable>(
        url: URL
        ,responseType: ResponseType.Type
        ,failure: FailureType.Type
        ,completion: @escaping (Result<ResponseType, Error>) -> Void) {

        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }

            if let data = data {
                do {
                    let result = try JSONDecoder().decode(ResponseType.self, from: data)
                    completion(.success(result))
                } catch {
                    do {
                        let errorResponse = try JSONDecoder().decode(FailureType.self, from: data) as! Error
                        DispatchQueue.main.async {
                            completion(.failure(errorResponse))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    
    // Function To handle Image Download
    class func downloadHandler(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(data,nil)
            }
        }
        task.resume()
    }
}

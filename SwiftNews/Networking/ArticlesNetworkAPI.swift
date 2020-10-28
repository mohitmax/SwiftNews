//
//  ArticlesNetworkAPI.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-26.
//

import UIKit

public class ArticlesNetworkAPI: NSObject {
    
    var session: URLSession {
        return URLSession(configuration: .ephemeral)
    }
    
    func getArticles(urlString: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        session.dataTask(with: url) {
            data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
               let resultDataKey = result["data"] as? [String: Any] {
                completion(.success(resultDataKey))
            } else {
                if let error = error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

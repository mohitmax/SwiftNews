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
    
    func getArticles(urlString: String, completion: @escaping (Result<ArticleResponseModel, Error>) -> Void) {
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
            
            do {
                let articleResponseModel = try! JSONDecoder().decode(ArticleResponseModel.self, from: data)
                print("Codable articleModel: \n \(articleResponseModel)")
                completion(.success(articleResponseModel))
            } catch let error {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
}

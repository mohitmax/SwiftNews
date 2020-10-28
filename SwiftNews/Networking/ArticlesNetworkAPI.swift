//
//  ArticlesNetworkAPI.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-26.
//

import UIKit

public class ArticlesNetworkAPI: NSObject {
    
    func getArticles(urlString: String, completion: @escaping (Result<[ArticleModel], Error>) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = session.dataTask(with: url) {
            data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            var articles = [ArticleModel]()
            
            if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                if let resultDataKey = result["data"] as? [String: Any] {
                    if let children = resultDataKey["children"] as? [[String: Any]] {
                     print("Children articles: \n\n \(children)")
                        
                        for child in children {
                            if let articleData = child["data"] as? [String: Any], let articleTitle = articleData["title"] as? String {
                                var thumbnail: String?
                                
                                if let pp = articleData["preview"] as? [String: Any] {
                                    if let images = pp["images"] as? [Any], let image = images.first as? [String: Any], let source = image["source"] as? [String: Any], let sourceImageUrlString = source["url"] as? String {
                                        print(sourceImageUrlString)
                                        thumbnail = sourceImageUrlString
                                    }
                                }
                                
                                let article = ArticleModel(title: articleTitle, thumbnailUrl: thumbnail)
                                articles.append(article)
                            }
                        }
                    }
                }
            }
            completion(.success(articles))
        }
        
        task.resume()
    }
}

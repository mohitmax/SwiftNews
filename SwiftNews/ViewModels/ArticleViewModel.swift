//
//  ArticleViewModel.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-26.
//

import Foundation
import UIKit

public class ArticleViewModel {
    var articles = [ArticleModel]()
    
    private func parse(json data: [String: Any]) {
        if let children = data["children"] as? [[String: Any]] {
         print("Children articles: \n\n \(children)")
            
            for child in children {
                if let articleData = child["data"] as? [String: Any], let articleTitle = articleData["title"] as? String {
                    var thumbnail: String?
                    
                    if let pp = articleData["preview"] as? [String: Any] {
                        if let images = pp["images"] as? [Any], let image = images.first as? [String: Any], let source = image["source"] as? [String: Any], let sourceImageUrlString = source["url"] as? String {
                            print(sourceImageUrlString)
                            let modifiedUrlString = sourceImageUrlString.replacingOccurrences(of: "&amp;", with: "&")
                            thumbnail = modifiedUrlString
                        }
                    }
                    
                    let article = ArticleModel(title: articleTitle, thumbnailUrl: thumbnail)
                    articles.append(article)
                }
            }
        }
    }
    
    func getRedditArticles(completion: @escaping (Result<Any?, Error>) -> Void) {
        let redditArticleUrlString = "https://www.reddit.com/r/swift/.json"
        ArticlesNetworkAPI().getArticles(urlString: redditArticleUrlString) { [unowned self] (result) in
            print("Result: \n \(result)")
            switch result {
            case .success(let articlesData):
                parse(json: articlesData)
                completion(.success(nil))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

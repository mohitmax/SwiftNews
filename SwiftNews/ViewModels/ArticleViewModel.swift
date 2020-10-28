//
//  ArticleViewModel.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-26.
//

import Foundation
import UIKit

public class ArticleViewModel {
    var articles: [ArticleModel]
    var thumbnail: UIImage?
    
    init(articles: [ArticleModel]) {
        self.articles = articles
    }
    
    func getRedditArticles(completion: @escaping (Result<[ArticleModel], Error>) -> Void) {
        let redditArticleUrlString = "https://www.reddit.com/r/swift/.json"
        ArticlesNetworkAPI().getArticles(urlString: redditArticleUrlString) { [unowned self] (result) in
            print("Result: \n \(result)")
            switch result {
            case .success(let articles):
                self.articles = articles
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

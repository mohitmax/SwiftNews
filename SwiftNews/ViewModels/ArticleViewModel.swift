//
//  ArticleViewModel.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-26.
//

import Foundation
import UIKit

public class ArticleViewModel {
    var articles = [ArticleDetailsModel]()
    
    private func formatResponseModel(_ model: ArticleResponseModel) {
        articles = model.data.children.compactMap { $0.data }
        articles = articles.map({ (model) -> ArticleDetailsModel in
            var mode = model
            mode.updateThumbnailUrl()
            return mode
        })
    }
    
    func getRedditArticles(completion: @escaping (Result<Any?, Error>) -> Void) {
        let redditArticleUrlString = Constants.swiftNewsUrlString
        ArticlesNetworkAPI().getArticles(urlString: redditArticleUrlString) { [unowned self] (result) in
            print("Result: \n \(result)")
            switch result {
            case .success(let articlesResponseModel):
                formatResponseModel(articlesResponseModel)
                completion(.success(nil))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

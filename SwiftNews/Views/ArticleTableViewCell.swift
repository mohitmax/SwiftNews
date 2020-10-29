//
//  ArticleTableViewCell.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-26.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    var articleModel: ArticleDetailsModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
        titleLabel.text = ""
    }
    
    func update(article: ArticleDetailsModel) {
        ImageCache.default.memoryStorage.config.totalCostLimit = 1
        
        titleLabel.text = article.title
        if let thumbnailUrlString = article.thumbnailUrl {
            thumbnail.isHidden = false
            loadImage(urlString: thumbnailUrlString)
        } else {
            thumbnail.isHidden = true
        }
    }
    
    func loadImage(urlString: String) {
        thumbnail.kf.indicatorType = .activity
        let url = URL(string: urlString)
//        thumbnail.kf.setImage(with: url)
        thumbnail.kf.setImage(with: url, completionHandler:  { result in
            switch result {
                case .success(let value):
                    // The image was set to image view:
                    print(value.image)

                    // From where the image was retrieved:
                    // - .none - Just downloaded.
                    // - .memory - Got from memory cache.
                    // - .disk - Got from disk cache.
                    print(value.cacheType)

                    // The source object which contains information like `url`.
                    print(value.source)

                case .failure(let error):
                    print(error) // The error happens
                }
        })
    }
    
}

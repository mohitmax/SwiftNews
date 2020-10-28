//
//  ArticleTableViewCell.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-26.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    var articleModel: ArticleModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
        titleLabel.text = ""
    }
    
    func update(article: ArticleModel) {
        titleLabel.text = article.title
        if let _ = article.thumbnailUrl {
            thumbnail.isHidden = false
        } else {
            thumbnail.isHidden = true
        }
    }
    
    func loadImage(urlString: String) {
        
    }
    
}

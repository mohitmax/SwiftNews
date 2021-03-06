//
//  ArticleDetailViewController.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-27.
//

import UIKit
import Kingfisher

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var articleUrlButton: UIButton!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    var article: ArticleDetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDetails()
        
        articleUrlButton.isEnabled = article?.articleUrl != nil
    }
    
    init(article: ArticleDetailsModel) {
        super.init(nibName: "ArticleDetailViewController", bundle: nil)
        self.article = article
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateDetails() {
        self.articleLabel.text = article?.title
        
        if let urlString = article?.thumbnailUrl {
            showArticleImage(urlString: urlString)
        } else {
            imageHeightConstraint.constant = 0.0
        }
    }
    
    func showArticleImage(urlString: String) {
        articleImage.kf.indicatorType = .activity
        let url = URL(string: urlString)
        articleImage.kf.setImage(with: url, placeholder: UIImage(systemName: "xmark.seal"))
    }

    @IBAction func readArticleDetails(_ sender: UIButton) {
        if let article = article {
            let articleUrlString = article.articleUrl
            let articleWebVC = ArticleWebViewController()
            articleWebVC.articleUrlString = articleUrlString
            articleWebVC.modalPresentationStyle = .popover
            self.present(articleWebVC, animated: true, completion: nil)
        }
    }
    
}

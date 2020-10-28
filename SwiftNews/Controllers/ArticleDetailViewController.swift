//
//  ArticleDetailViewController.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-27.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    var article: ArticleModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init(article: ArticleModel) {
        super.init(nibName: "ArticleDetailViewController", bundle: nil)
        self.article = article
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

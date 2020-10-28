//
//  ViewController.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-26.
//

import UIKit
import Foundation

class ViewController: UITableViewController {

    lazy var articleViewModel = ArticleViewModel(articles: loadSampleArticles())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
        getRedditArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexpath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexpath, animated: false)
        }
    }
    
    func getRedditArticles() {
        articleViewModel.getRedditArticles { (result) in
            switch result {
            case .success(let articles):
                print(articles)
                self.articleViewModel.articles = articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadSampleArticles() -> [ArticleModel] {
        var art = [ArticleModel]()
        for index in 1...5 {
            let art1 = ArticleModel(title: "Article number \(index) determines the policy of the indeterminate and calculative nature of the dimensions and the realms.")
            art.append(art1)
        }
        return art
    }
}

//MARK: UITableViewDataSource
extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articleViewModel.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("Cell is not of type articleTableViewCell")
        }
        
        let article = articleViewModel.articles[indexPath.row]
        cell.update(article: article)
        
        return cell
    }
    
}

//MARK: UITableViewDelegate
extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articleViewModel.articles[indexPath.row]
        let articleDetailVC = ArticleDetailViewController(article: article)
        
        navigationController?.pushViewController(articleDetailVC, animated: true)
    }
    
    
}

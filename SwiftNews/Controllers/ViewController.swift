//
//  ViewController.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-26.
//

import UIKit
import Foundation

class ViewController: UITableViewController {

    lazy var articleViewModel = ArticleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.tableFooterView = UIView(frame: .zero)
        
        getSwiftArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexpath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexpath, animated: false)
        }
    }
    
    func getSwiftArticles() {
        articleViewModel.getRedditArticles { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
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
        if indexPath.row < articleViewModel.articles.count {
            let article = articleViewModel.articles[indexPath.row]
            let articleDetailVC = ArticleDetailViewController(article: article)
            navigationController?.pushViewController(articleDetailVC, animated: false)
        }
    }
    
}

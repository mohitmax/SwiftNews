//
//  ArticleWebViewController.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-28.
//

import UIKit
import WebKit

class ArticleWebViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Properties
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    var articleUrlString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        webView.load(articleUrlString)
        webView.allowsBackForwardNavigationGestures = true
    }
    
}

extension ArticleWebViewController {
    func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            webView.bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            webView.rightAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension WKWebView {
    func load(_ urlString: String){
        if let myURL = URL(string: urlString) {
            let myRequest = URLRequest(url: myURL)
            self.load(myRequest)
        }
    }
}

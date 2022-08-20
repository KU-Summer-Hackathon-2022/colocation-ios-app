//
//  WebViewController.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {
    // MARK: - Properties
    var urlString = "https://shareroof.netlify.app/"
    
    // MARK: - Views
    let webView = WKWebView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        setupNavigationBar()
        setupWebView()
        
        loadWebView()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "🍂"
        self.navigationController?.navigationBar.backgroundColor = .green
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "북마킹",
            image: nil,
            primaryAction: nil,
            menu: nil
        )
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func loadWebView() {
        guard let url = URL(string: urlString) else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        print("✅ 웹을 열었습니다: \(url)")
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

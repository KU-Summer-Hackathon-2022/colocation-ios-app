//
//  WebViewController.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import UIKit
import WebKit
import SnapKit
import RxSwift

class WebViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    var urlString = ""
    
    var bookmarks = UserDefaults.standard.array(forKey: StringSet.UserDefaultKey.bookmark) as? [String] ?? [] {
        didSet {
            UserDefaults.standard.set(bookmarks, forKey: StringSet.UserDefaultKey.bookmark)
            print("asd \(bookmarks), \(UserDefaults.standard.array(forKey: StringSet.UserDefaultKey.bookmark))")
        }
    }
    
    // MARK: - Views
    let webView = WKWebView()
    let rightBarButton = UIBarButtonItem(
        title: nil,
        image: UIImage(systemName: "heart"),
        primaryAction: nil,
        menu: nil
    )

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupWebView()
        
        loadWebView()
        bind()
    }
    
    private func bind() {
        self.navigationItem.rightBarButtonItem?.rx.tap
            .bind { [weak self] _ in
                print("dsasdfg 🥳🥳🥳 \(self?.urlString)")
                
                let id = self?.urlString.components(separatedBy: "/").last!
                print("dsasdfg 🥳🥳🥳 asdf id \(id)")
                var bookmarks = UserDefaults.standard.array(forKey: StringSet.UserDefaultKey.bookmark) as? [String] ?? []
                
                if self?.rightBarButton.image == UIImage(systemName: "heart.fill") {
                    print("🥳 fill true")
                    self?.rightBarButton.image = UIImage(systemName: "heart")
                    self?.bookmarks.removeAll { target in
                        target == "\(id!)"
                    }
                } else {
                    print("🥳fill false")
                    self?.rightBarButton.image = UIImage(systemName: "heart.fill")
                    self?.bookmarks.append("\(id!)")
                }
                
                print("-: ->\(UserDefaults.standard.array(forKey: StringSet.UserDefaultKey.bookmark))")
                
            }
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "숙소 상세 페이지"
        self.navigationController?.navigationBar.backgroundColor = ColorSet.AppColor.primary
        let id = self.urlString.components(separatedBy: "/").last!
        if bookmarks.contains(id) {
            rightBarButton.image = UIImage(systemName: "heart.fill")
        } else {
            rightBarButton.image = UIImage(systemName: "heart")
        }
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("🌿 \(#function)")
        
        setupNavigationBar()
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

extension WebViewController {
    
}

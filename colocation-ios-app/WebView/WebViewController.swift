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
    let rightBarButton = UIBarButtonItem(
        title: nil,
        image: UIImage(systemName: "heart"),
        primaryAction: nil,
        menu: nil
    )
    let webView = WKWebView()
    let applyButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorSet.AppColor.primary
        
        setupNavigationBar()
        setupWebView()
        
        loadWebView()
        bind()
    }
        
    
    
    private func bind() {
        self.navigationItem.rightBarButtonItem?.rx.tap
            .bind { [weak self] _ in
                let id = self?.urlString.components(separatedBy: "/").last!
                
                if self?.rightBarButton.image == UIImage(systemName: "heart.fill") {
                    self?.rightBarButton.image = UIImage(systemName: "heart")
                    self?.bookmarks.removeAll { target in
                        target == "\(id!)"
                    }
                } else {
                    self?.rightBarButton.image = UIImage(systemName: "heart.fill")
                    self?.bookmarks.append("\(id!)")
                }
                
            }
            .disposed(by: disposeBag)
        
        applyButton.rx.tap
            .bind { [weak self] _ in
                let alertController = UIAlertController(
                    title: "😲 신청이 완료되었어요.",
                    message: "신청 수락 여부는 마이페이지에서 확인할 수 있어요.",
                    preferredStyle: .alert
                )
                let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                    self?.applyButton.isEnabled = false
                    self?.applyButton.backgroundColor = .gray
                    self?.applyButton.setTitle("🙌🏻 신청완료!", for: .disabled)
                    self?.view.backgroundColor = .gray
                    let id = self?.urlString.components(separatedBy: "/").last
                    print("✅ id \(id)")
                    UserDefaults.standard.set([id], forKey: StringSet.UserDefaultKey.applyRoom)
                }
                
                alertController.addAction(confirmAction)
                self?.present(alertController, animated: true)
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
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        webView.addSubview(applyButton)
        
        applyButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("🌿 \(#function)")
        
        setupNavigationBar()
        updateApplyButton()
    }
    
    func updateApplyButton() {
        let applyRooms = UserDefaults.standard.array(
            forKey: StringSet.UserDefaultKey.applyRoom
        ) as? [String] ?? []
        let id = self.urlString.components(separatedBy: "/").last!
        print("✅ urlString- id \(id) \(applyRooms)")
        
        // FIXME: - contains가 오류가나서 어쩔 수 없이 급한대로
        var isContain: Bool = false
        applyRooms.forEach { str in
            if str == id {
                isContain = true
            }
        }
        
        if !isContain {
            applyButton.isEnabled = true
            applyButton.setTitle("신청하기", for: .normal)
            applyButton.backgroundColor = ColorSet.AppColor.primary
        } else {
            applyButton.isEnabled = false
            applyButton.backgroundColor = .gray
            applyButton.setTitle("🙌🏻 신청완료!", for: .disabled)
            view.backgroundColor = .gray
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

extension WebViewController {
    
}

//
//  UIViewController+.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import UIKit

extension UIViewController {
    /// 웹뷰를 보여줍니다.
    func showWebViewController(_ urlString: String, action: (() -> Void)? = nil) {
        let webViewController = WebViewController()
        webViewController.urlString = urlString
        let nav = UINavigationController(rootViewController: webViewController)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(nav, animated: true, completion: nil)
    }
    
    func showRoomTableViewController() {
        let vc = RoomTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showMyPageTableViewController() {
        let vc = MyPageTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAuthViewController() {
        let vc = AuthViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showBookmarkViewController() {
        let vc = BookmarkViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showApplyRoomViewController() {
        let vc = ApplyRoomViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

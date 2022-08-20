//
//  UIViewController+.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import UIKit

extension UIViewController {
    /// 웹뷰를 보여줍니다.
    func showWebViewController(_ urlString: String) {
        let nav = UINavigationController(rootViewController: WebViewController())
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
}

//
//  MyPageViewController.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MyPageViewController: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        [tableView].forEach { view.addSubview($0) }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    
}

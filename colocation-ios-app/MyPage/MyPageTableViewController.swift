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

class MyPageTableViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind()
    }
    
    func setupViews() {
        [tableView].forEach { view.addSubview($0) }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            MyPageTableViewCell.self,
            forCellReuseIdentifier: MyPageTableViewCell.identifier
        )
        tableView.rowHeight = 40
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind() {
        tableView.rx.itemSelected
            .bind { [weak self] indexPath in
                guard let self = self else { return }
                let row = indexPath.row
                
                if row == 0 {
                    self.showAuthViewController()
                } else if row == 1 {
                    self.showBookmarkViewController()
                }
            }
            .disposed(by: disposeBag)
    }
}

extension MyPageTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MyPageTableViewCell.identifier,
            for: indexPath
        ) as? MyPageTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.setUI(item: Setting.settings[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "딩동댕"
    }
}

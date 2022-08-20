//
//  ListViewController.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RoomTableViewController: UIViewController {
    
    // MARK: - Properties
    var rooms: [Room] = Room.makeServerRooms()
    
    // MARK: - Views
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()        
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            RoomTableViewCell.self,
            forCellReuseIdentifier: RoomTableViewCell.identifier
        )
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension RoomTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RoomTableViewCell.identifier,
            for: indexPath
        ) as? RoomTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.setUI(item: rooms[indexPath.row])
                
        return cell
    }
}


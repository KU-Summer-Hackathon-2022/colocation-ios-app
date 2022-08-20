//
//  BookmarkViewController.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class BookmarkViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var rooms: [Room] = Room.makeServerRooms()
    var bookmarks = UserDefaults.standard.array(forKey: StringSet.UserDefaultKey.bookmark) as? [String] ?? []
    
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

extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformBookmarks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RoomTableViewCell.identifier,
            for: indexPath
        ) as? RoomTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.setUI(item: transformBookmarks()[indexPath.row])
        
        return cell
    }
    
    private func transformBookmarks() -> [Room] {
        let rooms: [Room] = Room.makeServerRooms()
        let bookmarks = UserDefaults.standard.array(forKey: StringSet.UserDefaultKey.bookmark) as? [String] ?? []
        
        var result = [Room]()
        rooms.forEach { room in
            if bookmarks.contains(room.id) {
                result.append(room)
            }
        }
        
        print("👉 result \(result)")
        return result
    }
}



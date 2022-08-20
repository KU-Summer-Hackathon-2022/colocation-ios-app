//
//  ApplyRoomViewController.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/21.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ApplyRoomViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var rooms: [Room] = Room.makeServerRooms()
    var bookmarks = UserDefaults.standard.array(forKey: StringSet.UserDefaultKey.applyRoom) as? [String] ?? []
    
    let tableView = UITableView()
    
    /// 단일 신청된 룸
    var applyRoom = [Room]()
    
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

extension ApplyRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        let bookmarks = UserDefaults.standard.array(forKey: StringSet.UserDefaultKey.applyRoom) as? [String] ?? []
        
        
        rooms.forEach { room in
            if bookmarks.contains(room.id) {
                applyRoom.append(room)
            }
        }
        
        print("👉 result \(applyRoom)")
        return applyRoom
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showWebViewController("https://shareroof.netlify.app/houses/\(applyRoom[0].id)") {
            self.tableView.reloadData()
        }
    }
}

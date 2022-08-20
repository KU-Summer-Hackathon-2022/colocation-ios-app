//
//  RoomTableViewCell.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RoomTableViewCell: UITableViewCell {
    // 이미지, 가격, 주소, 유형
    let thumbnailImageView = UIImageView()
    let priceLabel = UILabel()
    let adressLabel = UILabel()
    let typeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(item: Room) {
        thumbnailImageView.image = UIImage(named: "item.imageString")
        priceLabel.text = item.price
        adressLabel.text = item.address
        typeLabel.text = item.type
    }
    
    private func setupViews() {
        [thumbnailImageView, priceLabel, adressLabel, typeLabel].forEach { contentView.addSubview($0) }
        
        thumbnailImageView.image = UIImage()
        thumbnailImageView.backgroundColor = .gray
        thumbnailImageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.top.leading.equalTo(10)
        }
        thumbnailImageView.sizeToFit()
        thumbnailImageView.layer.cornerRadius = 5
        thumbnailImageView.clipsToBounds = true
        
        priceLabel.text = "priceLabel"
        priceLabel.textColor = ColorSet.Highlight.primary
        priceLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.top)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
        }
        
        typeLabel.text = "typeLabel"
        typeLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        typeLabel.snp.makeConstraints {
            $0.bottom.equalTo(thumbnailImageView.snp.bottom)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
        }
        
        adressLabel.text = "adressLabel"
        adressLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        adressLabel.snp.makeConstraints {
            $0.bottom.equalTo(typeLabel.snp.top).offset(-5)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
        }
        
        

    }
}

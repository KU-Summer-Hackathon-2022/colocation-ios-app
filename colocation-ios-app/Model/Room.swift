//
//  RoomModel.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import Foundation

/*
 - 주소 (나라)  - 0
 - 위도
 - 경도
 - 사진
 - 이미지 이름
 - 주인장 성별
 - 집 유형(호텔, 단독 주택 등등) - 5
 - 집 크기
 - 가격
 - 화장실 공용 여부
 - 침대 갯수
 - 카쉐어링
 */

struct Room: Equatable {
    var id: String // 고유 아이디
    var address: String // 국가
    var latitudeValue: String // 위도
    var longitudeValue: String // 경도
    var imageString: String // 이미지
    var gender: String // 성별
    var type: String // 집 유형
    var roomSize: String // 집 크기
    var price: String // 가격
    var isToiletShare: String // 화장실 공용 여부
    var bedCount: String // 침대 갯수
    var isCarShare: String // 카쉐어링 여부
    
    var isLike: Bool = false // 좋아요 여부
    
    init(
        id: String,
        address: String,
        latitudeValue: String,
        longitudeValue: String,
        imageString: String,
        gender: String,
        type: String,
        roomSize: String,
        price: String,
        isToiletShare: String,
        bedCount: String,
        isCarShare: String,
        isLike: Bool = false
    ) {
        self.id = id
        self.address = address
        self.latitudeValue = latitudeValue
        self.longitudeValue = longitudeValue
        self.imageString = imageString
        self.gender = gender
        self.type = type
        self.roomSize = roomSize
        self.price = price
        self.isToiletShare = isToiletShare
        self.bedCount = bedCount
        self.isCarShare = isCarShare
        self.isLike = isLike
    }
}

extension Room {
    static let Rooms: [Room] = [
        Room(id: "0", address: "국가는", latitudeValue: "37.556876", longitudeValue: "126.914066", imageString: "", gender: "boy", type: "빌라", roomSize: "15", price: "10달러", isToiletShare: "true", bedCount: "3", isCarShare: "false"),
        Room(id: "1", address: "국가는", latitudeValue: "37.556876", longitudeValue: "126.914066", imageString: "", gender: "boy", type: "빌라", roomSize: "15", price: "11달러", isToiletShare: "true", bedCount: "3", isCarShare: "false"),
        Room(id: "2", address: "국가는", latitudeValue: "37.556876", longitudeValue: "126.914066", imageString: "", gender: "boy", type: "빌라", roomSize: "15", price: "12달러", isToiletShare: "true", bedCount: "3", isCarShare: "false"),
        Room(id: "3", address: "국가는", latitudeValue: "37.556876", longitudeValue: "126.914066", imageString: "", gender: "boy", type: "빌라", roomSize: "15", price: "13달러", isToiletShare: "true", bedCount: "3", isCarShare: "false")
    ]
}

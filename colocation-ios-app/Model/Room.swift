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

struct Room {
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
    
    init(
        country: String,
        latitudeValue: String,
        longitudeValue: String,
        imageString: String,
        gender: String,
        type: String,
        roomSize: String,
        price: String,
        isToiletShare: String,
        bedCount: String,
        isCarShare: String
    ) {
        self.address = country
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
    }
    
}

extension Room {
    static let Rooms: [Room] = [
        Room(country: "국가", latitudeValue: "37.556876", longitudeValue: "126.914066", imageString: "", gender: "boy", type: "빌라", roomSize: "16", price: "13달러", isToiletShare: "true", bedCount: "1", isCarShare: "false"),
        Room(country: "국가", latitudeValue: "37.556876", longitudeValue: "126.914066", imageString: "", gender: "boy", type: "빌라", roomSize: "16", price: "13달러", isToiletShare: "true", bedCount: "1", isCarShare: "false"),
        Room(country: "국가", latitudeValue: "37.556876", longitudeValue: "126.914066", imageString: "", gender: "boy", type: "빌라", roomSize: "16", price: "13달러", isToiletShare: "true", bedCount: "1", isCarShare: "false"),
        Room(country: "국가", latitudeValue: "37.556876", longitudeValue: "126.914066", imageString: "", gender: "boy", type: "빌라", roomSize: "16", price: "13달러", isToiletShare: "true", bedCount: "1", isCarShare: "false")
    ]
}

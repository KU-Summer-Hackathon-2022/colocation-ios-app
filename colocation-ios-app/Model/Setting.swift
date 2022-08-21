//
//  MyPage.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import Foundation

struct Setting {
    var title: String
}

extension Setting {
    static let settings: [Setting] = [
        Setting(title: "🍁 로그인 및 회원가입"),
        Setting(title: "🍁 관심목록"),
        Setting(title: "🍁 예약현황"),
//        Setting(title: "🍁 후기작성"),
    ]
}

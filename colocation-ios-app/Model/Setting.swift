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
    static private var authTitle: String {
        UserDefaults.standard.string(forKey: StringSet.UserDefaultKey.authToken) == nil
        ? "로그인 및 회원가입"
        : "이미 가입한 유저입니다"
    }
    
    static let settings: [Setting] = [
        Setting(title: "👉 \(authTitle)"),
        Setting(title: "👉 관심목록"),
        Setting(title: "👉 예약현황"),
//        Setting(title: "🍁 후기작성"),
    ]
}

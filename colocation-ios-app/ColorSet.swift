//
//  ColorSet.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import UIKit

// NOTE: - 다크모드 대응을 위한 함수 작성하기
struct ColorSet {
    
    struct AppColor {
        static let primary: UIColor = .init(rgb: 0x004a7c)
        static let secondary: UIColor = .init(rgb: 0x005691)
        static let tertiary: UIColor = .init(rgb: 0xe8f1f5)
    }
    
    /// 강조에 사용되는 컬러셋
    struct Highlight {
        static let primary: UIColor = .init(red: 236/255, green: 94/255, blue: 101/255, alpha: 1.0)
        static let secondary: UIColor = .init(rgb: 0x005691)
        static let tertiary: UIColor = .init(rgb: 0x005691)
    }
    
    struct Label {
        static let primary: UIColor = .init()
        static let secondary: UIColor = .init(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
    }
}

//
//  StringSet.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/20.
//

import Foundation

struct StringSet {
    
    struct UserDefaultKey {
        fileprivate static let baseString = "com.ios.colocation"
        
        static let authToken = "\(baseString).auth.token"
        static let bookmark = "\(baseString).bookmark"
    }
    
    
}

//
//  TokenInfo.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/28.
//

import Foundation

@propertyWrapper
struct UserDefault {
    private let key: String
 
    var wrappedValue: String {
        get { UserDefaults.standard.string(forKey: key) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
 
    init(key: String) {
        self.key = key
    }
}

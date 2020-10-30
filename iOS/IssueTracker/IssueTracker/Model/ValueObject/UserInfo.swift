//
//  UserInfo.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/28.
//

import Foundation

// 어느 곳에서든 접근할 수 있도록 static 으로 선언

class UserInfo {
    
    static let shared = UserInfo()
    
    @UserDefault(key: "name") var userName: String
    @UserDefault(key: "accessToken") var accessToken: String
    @UserDefault(key: "refreshToken") var refreshToken: String
    
    
    func isAllInfoExisted() -> Bool {
        
        if userName != "" &&
            accessToken != "" &&
            refreshToken != ""  {
            return true
        } else {
            return false
        }
    }
    
}

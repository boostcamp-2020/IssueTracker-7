//
//  UserInfo.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/28.
//

import Foundation

// 어느 곳에서든 접근할 수 있도록 static 으로 선언

struct UserInfo {
    @UserDefault(key: "name") static var userName: String
    
    @UserDefault(key: "accessToken") static var accessToken: String
    @UserDefault(key: "refreshToken") static var refreshToken: String
}

//
//  TokenManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import UIKit

class TokenManager {
        
    
    // 백엔드에 Token 요청할 Url
    let tokenUrl = ""
//    let renewTokenUrl = ""
    
    init() {
        setUpNotification()
    }
    
    func setUpNotification() {
        
    }
    
    // Token Manager
    // 1. 최초에 어세스토큰 / 리프레쉬 토큰을 얻음 -> property wrapper 를 이용한 Userdefaults 에 저장
    
    func requestToken() {
        HTTPManager.openSite(url: tokenUrl)
    }
    
    // 2. 419번 코드가 오면 어세스토큰/리프레쉬 토큰을 보내서 어세스 토큰 갱신 후 Userdefaults 에 저장
//    func renewToken() {
//
//    }
    
    
}

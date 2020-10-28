//
//  TokenManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import UIKit

class TokenManager {
    
    // 싱글톤으로 해야할지..?
    // -> renewToken 은 로그인/이슈/마일스톤/라벨 등 APP 전반에 걸쳐 모든 Model 에서 쓰여야하는데 그 때마다 TokenManager 객체를 만들어주는 것보다는 싱글톤이 좋지 않을지?
    
    // 백엔드 통신용
    // let url1 => 최초 Token 요청
    // let url2 => Token 갱신 요청
    
    // Token Manager
    // 1. 최초에 어세스토큰 / 리프레쉬 토큰을 얻음 -> property wrapper 를 이용한 Userdefaults 에 저장
    
    func requestToken() {
        
        
        
    }
    
    // 2. 419번 코드가 오면 어세스토큰/리프레쉬 토큰을 보내서 어세스 토큰 갱신 후 Userdefaults 에 저장

    func renewToken() {
        
    }
    
    
}

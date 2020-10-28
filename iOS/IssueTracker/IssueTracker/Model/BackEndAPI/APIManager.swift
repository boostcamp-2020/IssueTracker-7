//
//  APIManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import Foundation

// 네트워크 요청(URLSession) 객체를 분리


protocol protocolName {
    func request()

}


class APIManager {
    
    let api종류: protocolName
    
    init(apiProtocol: protocolName) {
        self.api종류 = apiProtocol
    }
    
    func request() {
        api종류.request()
    }
    
    // IssueManager
    // 마일스톤
    
    
  
    
}

//
//  OAuthManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import Foundation

protocol OAuthAble {
    func requestAuthorization()
}

class OAuthManager {
    private let oauth: OAuthAble
    
    init (oauth: OAuthAble) {
        self.oauth = oauth
    }
    
    func requestAuthorization() {
        oauth.requestAuthorization()
    }
    
}

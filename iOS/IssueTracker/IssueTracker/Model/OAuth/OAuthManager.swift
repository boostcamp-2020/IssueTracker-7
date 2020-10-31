//
//  OAuthManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import Foundation

protocol OAuthable {
    var handler: (() -> ())? { get set }
    func requestAuthorization()
}

class OAuthManager {
    private var oauth: OAuthable
    
    init (oauth: OAuthable, handler: (()->())? = nil) {
        self.oauth = oauth
        self.oauth.handler = handler
    }
    
    func requestAuthorization() {
        oauth.requestAuthorization()
    }
    
}

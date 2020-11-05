//
//  AuthenticationManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import UIKit

class BackEndOAuthManager {
        
    private let router = Router<BackEndAPI>()
    var handler: (() -> ())?
    
    init() {
        setUpNotificationCenter()
    }
    
    func setUpNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveToken), name: Notification.Name.backEndTokenReceived, object: nil)
    }
    
    @objc func receiveToken() {
        if let handler = handler { handler() }
    }
    
    
}

extension BackEndOAuthManager: OAuthable {
    func requestAuthorization() {
        router.openSite(from: .token)
    }
    
    
}

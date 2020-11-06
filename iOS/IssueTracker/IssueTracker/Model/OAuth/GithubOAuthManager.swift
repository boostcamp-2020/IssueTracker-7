//
//  GithubLoginManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import Foundation

class GithubOAuthManager {
    
    private let router = Router<GithubAPI>()
    var handler: (() -> ())?
    
    init() {
        setUpNotificationCenter()
    }
    
    func setUpNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(requestGithubToken), name: Notification.Name("complete"), object: nil)
    }
    
    
    
    @objc func requestGithubToken(notification: Notification) {
        guard let code = notification.userInfo?["code"] as? String else { return }
        
        router.request(route: .accessToken(code: code)) { (result: Result<GithubTokenData, APIError>)  in
            switch result {
            case .success(let tokenData):
                let accessToken = tokenData.accessToken
                UserInfo.shared.accessToken = accessToken
                if let handler = self.handler { handler() }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension GithubOAuthManager: OAuthable {
    func requestAuthorization() {
        router.openSite(from: .code)
    }
}

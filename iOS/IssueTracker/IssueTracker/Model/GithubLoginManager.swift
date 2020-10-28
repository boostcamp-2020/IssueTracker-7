//
//  GithubLoginManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import Foundation

class GithubLoginManager {
    
    // code 얻기
    let codeUrl = "https://github.com/login/oauth/authorize?client_id=\(GithubAPICredentials.clientId)&scope=user"
    // AccessToken 얻기
    let accessTokenUrl = "https://github.com/login/oauth/access_token"
    
    let githubAPIUrl = "https://api.github.com/user"
    
    init() {
        setUpNotificationCenter()
    }
    
    
    func setUpNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(requestGithubToken), name: Notification.Name("complete"), object: nil)
    }
    
    @objc func requestGithubToken(notification: Notification) {
        guard let code = notification.userInfo?["code"] as? String else { return }
        let body = ["client_id": GithubAPICredentials.clientId, "client_secret": GithubAPICredentials.clientSecret, "code": code]
        let header = ["Accept": "application/json"]
        
        HTTPManager.request(method: .post, url: accessTokenUrl, body: body, header: header) { data, error in
            guard let githubJSONData = try? JSONDecoder().decode(GithubJSONData.self, from: data) else { return }
            let accessToken = githubJSONData.accessToken
            let header = ["Authorization": "token \(accessToken)"]
            
            HTTPManager.request(method: .get, url: self.githubAPIUrl, header: header) { data, error in
                print(try! JSONSerialization.jsonObject(with: data, options: []))
            }
        }
    }
}

extension GithubLoginManager: OAuthAble {
    func requestAuthorization() {
        HTTPManager.openSite(url: codeUrl)
    }
}

//
//  GithubAPIManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/31.
//

import Foundation

class GithubAPIManager {
    
    private let router = Router<GithubAPI>()
    
    func requestUserInfo(accessToken: String) {
        router.request(route: .userInfo(accessToken: accessToken)) { (result: Result<GithubUserInfo, APIError>) in
            switch result {
            case .success(let userInfo):
                print(userInfo)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

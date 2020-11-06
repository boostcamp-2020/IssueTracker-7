//
//  GithubAPI.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/30.
//

import Foundation

enum GithubAPI {
    case code
    case accessToken(code: String)
    case userInfo(accessToken: String)
}

extension GithubAPI: EndPointable {
    var environmentBaseURL: String {
        switch self {
        case .code:
            return "https://github.com/login/oauth/authorize"
        case .accessToken:
            return "https://github.com/login/oauth/access_token"
        case .userInfo:
            return "https://api.github.com/user"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError() } // TODO: 예외처리로 바꿔주기
        return url
    }
    
    var query: String {
        switch self {
        case .code:
            return "?client_id=\(GithubAPICredentials.clientId)&scope=user"
        default:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod? {
        switch self {
        case .accessToken:
            return .post
        case .userInfo:
            return .get
        default:
            return nil
        }
    }
    
    var headers: HTTPHeader? {
        switch self {
        case .accessToken:
            return ["Accept": "application/json"]
        case .userInfo(let accessToken):
            return ["Authorization": "token \(accessToken)"]
        default:
            return nil
        }
    }
    
    var bodies: HTTPBody? {
        switch self {
        case .accessToken(let code):
            return ["client_id": GithubAPICredentials.clientId, "client_secret": GithubAPICredentials.clientSecret, "code": code]
        default:
            return nil
        }
    }
}

//
//  BackEndAPI.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/31.
//

import Foundation

enum BackEndAPI {
    case token
    case allIssues
    
    case allAuthors,
         allLabels,
         allMilestones,
         allAssignees
    
    case filterIssueList
}

extension BackEndAPI: EndPointable, CaseIterable {
    var environmentBaseURL: String {
        switch self {
        case .token:
            return "http://\(BackEndAPICredentials.ip)/api/auth/github/ios"
        case .allIssues:
            return "http://\(BackEndAPICredentials.ip)/api/issue"
        default:
            return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError() } // TODO: 예외처리로 바꿔주기
        return url
    }
    
    var query: String {
        return ""
    }
    
    var httpMethod: HTTPMethod? {
        switch self {
        case .token:
            return .post
        case .allIssues:
            return .get
        default:
            return nil
        }
    }
    
    var headers: HTTPHeader? {
        return ["Authorization": "bearer \(UserInfo.shared.accessToken)"]
    }
    
    var bodies: HTTPBody? {
        return nil
    }
}


//var bodies: HTTPBody? {
//    switch self {
//    case .accessToken(let code):
//        return ["client_id": GithubAPICredentials.clientId, "client_secret": GithubAPICredentials.clientSecret, "code": code]
//    default:
//        return nil
//    }
//}

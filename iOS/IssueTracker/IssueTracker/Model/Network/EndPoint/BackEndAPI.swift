//
//  BackEndAPI.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/31.
//

import Foundation

enum BackEndAPI {
    case token
    case Issues
    
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
        case .Issues:
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
        case .Issues:
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

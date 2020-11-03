//
//  BackEndAPI.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/31.
//

import Foundation

enum BackEndAPI {
    case token
    
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
            return "http://192.168.0.31/api/auth/github"
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
        default:
            return nil
        }
    }
    
    var headers: HTTPHeader? {
        return nil
    }
    
    var bodies: HTTPBody? {
        return nil
    }
}

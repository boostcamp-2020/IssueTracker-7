//
//  BackEndAPI.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/31.
//

import Foundation

enum BackEndAPI {
    case allAuthors,
         allLabels,
         allMilestones,
         allAssignees
    
    case filterIssueList
}

extension BackEndAPI: EndPointable, CaseIterable {
    var environmentBaseURL: String {
        return ""
    }
    
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var query: String {
        return ""
    }
    
    var httpMethod: HTTPMethod? {
        return nil
    }
    
    var headers: HTTPHeader? {
        return nil
    }
    
    var bodies: HTTPBody? {
        return nil
    }
}

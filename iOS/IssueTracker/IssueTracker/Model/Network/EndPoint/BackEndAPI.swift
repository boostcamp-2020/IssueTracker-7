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
    case addNewMilestone(milestoneName: String,  milestoneDueDate: String, milestoneDescription: String)
    case editExistingMilestone(milestoneId: Int, milestoneName: String,  milestoneDueDate: String, milestoneDescription: String)
}

extension BackEndAPI: EndPointable {
    var environmentBaseURL: String {
        switch self {
        case .token:
            return "http://\(BackEndAPICredentials.ip)/api/auth/github/ios"
        case .allIssues:
            return "http://\(BackEndAPICredentials.ip)/api/issue"
        case .allMilestones:
            return "http://\(BackEndAPICredentials.ip)/api/milestone"
        case .addNewMilestone(_, _, _):
            return "http://\(BackEndAPICredentials.ip)/api/milestone"
        case .editExistingMilestone(let milestoneId, _, _, _):
            return "http://\(BackEndAPICredentials.ip)/api/milestone/\(milestoneId)"
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
        case .allMilestones:
            return .get
        case .addNewMilestone:
            return .post
        case .editExistingMilestone:
            return .put
        default:
            return nil
        }
    }
    
    var headers: HTTPHeader? {
        return ["Authorization": "bearer \(UserInfo.shared.accessToken)", "content-type": "application/x-www-form-urlencoded"]
    }
    
    var bodies: HTTPBody? {
        switch self {
        case .addNewMilestone(let milestoneName, let milestoneDueDate, let milestoneDescription):
            let bodyDictionary = ["title": milestoneName,
                                  "due_date": milestoneDueDate,
                                  "description": milestoneDescription]
            return bodyDictionary
        case .editExistingMilestone(_, let milestoneName, let milestoneDueDate, let milestoneDescription):
            let bodyDictionary = ["title": milestoneName,
                                  "due_date": milestoneDueDate,
                                  "description": milestoneDescription]
            return bodyDictionary
        default:
            return nil
        }
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

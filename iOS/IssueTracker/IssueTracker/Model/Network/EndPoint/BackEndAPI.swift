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
    case addNewLabel(labelName: String, labelDescription: String, labelColor: String)
    case editExistingLabel(labelId: Int, labelName: String, labelDescription: String, labelColor: String)
    
    case addNewMilestone(milestoneName: String,  milestoneDueDate: String, milestoneDescription: String)
    case editExistingMilestone(milestoneId: Int, milestoneName: String,  milestoneDueDate: String, milestoneDescription: String)

    case predefinedFilter(query: String)

}

extension BackEndAPI: EndPointable {
    var environmentBaseURL: String {
        switch self {
        case .token:
            return "http://\(BackEndAPICredentials.ip)/api/auth/github/ios"
        case .allIssues:
            return "http://\(BackEndAPICredentials.ip)/api/issue"
        case .allLabels:
            return "http://\(BackEndAPICredentials.ip)/api/label"
        case .addNewLabel:
            return "http://\(BackEndAPICredentials.ip)/api/label"
        case .editExistingLabel(let labelId, _, _, _):
            return "http://\(BackEndAPICredentials.ip)/api/label/\(labelId)"
        case .allMilestones:
            return "http://\(BackEndAPICredentials.ip)/api/milestone"
        case .allAssignees, .allAuthors:
            return "http://\(BackEndAPICredentials.ip)/api/user"
        case .predefinedFilter:
            return "http://\(BackEndAPICredentials.ip)/api/issue"
        case .addNewMilestone(_, _, _):
            return "http://\(BackEndAPICredentials.ip)/api/milestone"
        case .editExistingMilestone(let milestoneId, _, _, _):
            return "http://\(BackEndAPICredentials.ip)/api/milestone/\(milestoneId)"
        }
    }
    
    var baseURL: URLComponents {
        guard let url = URLComponents(string: environmentBaseURL) else { fatalError() } // TODO: 예외처리로 바꿔주기
        return url
    }
    
    var query: [String: String]? {
        switch self {
        case .predefinedFilter(let query):
            return ["q": query]
        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod? {
        switch self {
        case .token:
            return .post
        case .allIssues:
            return .get
        case .allLabels:
            return .get
        case .addNewLabel:
            return .post
        case .editExistingLabel:
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
        case .addNewLabel(let labelName, let labelDescription, let labelColor):
            let bodyDictionary = ["name": labelName,
                                  "description": labelDescription,
                                  "color": labelColor]
            return bodyDictionary
        case .editExistingLabel(_, let labelName, let labelDescription, let labelColor):
            let bodyDictionary = ["name": labelName,
                                  "description": labelDescription,
                                  "color": labelColor]
        case .addNewMilestone(let milestoneName, let milestoneDueDate, let milestoneDescription),
             .editExistingMilestone(_, let milestoneName, let milestoneDueDate, let milestoneDescription):
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

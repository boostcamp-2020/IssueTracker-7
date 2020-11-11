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
        case .allLabels:
            return .get
        case .addNewLabel:
            return .post
        case .editExistingLabel:
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

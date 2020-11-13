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
 
    case addNewIssue(title: String, content: String)
    
    case addNewLabel(labelName: String, labelDescription: String, labelColor: String)
    case editExistingLabel(labelId: Int, labelName: String, labelDescription: String, labelColor: String)

    case addNewMilestone(milestoneName: String,  milestoneDueDate: String, milestoneDescription: String)
    case editExistingMilestone(milestoneId: Int, milestoneName: String,  milestoneDueDate: String, milestoneDescription: String)

    case predefinedFilter(query: String)
    case closeIssue(issueNumber: String, title: String, status: String)
    
    case addAssignee(issueNumber: String, userID: Int),
         deleteAssignee(issueNumber: String, userID: Int)
    
    case photo(path: String)
    
    case addComment(issueId: Int, content: String)
}

extension BackEndAPI: EndPointable {
    var environmentBaseURL: String {
        switch self {
        case .token:
            return "http://\(BackEndAPICredentials.ip)/api/auth/github/ios"
        case .allIssues, .addNewIssue:
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
        case .closeIssue(let issueNumber, _, _):
            return "http://\(BackEndAPICredentials.ip)/api/issue/\(issueNumber)"
        case .addNewMilestone(_, _, _):
            return "http://\(BackEndAPICredentials.ip)/api/milestone"
        case .editExistingMilestone(let milestoneId, _, _, _):
            return "http://\(BackEndAPICredentials.ip)/api/milestone/\(milestoneId)"
        case .photo(let path):
            return "\(path)"
        case .addAssignee(let issueNumber, _):
            return "http://\(BackEndAPICredentials.ip)/api/issue/\(issueNumber)/assignee"
        case .deleteAssignee(let issueNumber, let userID):
            return "http://\(BackEndAPICredentials.ip)/api/issue/\(issueNumber)/assignee/\(userID)"
        case .addComment(let issueId, _):
            return "http://\(BackEndAPICredentials.ip)/api/issue/\(issueId)/comment"
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
        case .allIssues, .allLabels, .allMilestones, .allAssignees, .allAuthors, .predefinedFilter:
            return .get
        case .closeIssue:
            return .put
        case .addNewLabel, .addNewIssue, .addComment:
            return .post
        case .editExistingLabel:
            return .put
        case .addNewMilestone:
            return .post
        case .editExistingMilestone:
            return .put
        case .photo:
            return .get
        case .addAssignee:
            return .post
        case .deleteAssignee:
            return .delete
        default:
            return nil
        }
    }
    
    var headers: HTTPHeader? {
        return ["Authorization": "bearer \(UserInfo.shared.accessToken)", "content-type": "application/x-www-form-urlencoded"]
    }
    
    var bodies: HTTPBody? {
        switch self {
        case .closeIssue(_, let title, let status):
            return ["title": "\(title)", "status":"\(status)"]
        case .addNewIssue(let title, let content):
            return ["title": title, "content": content]
        case .addNewLabel(let labelName, let labelDescription, let labelColor),
             .editExistingLabel(_, let labelName, let labelDescription, let labelColor):
            let bodyDictionary = ["name": labelName,
                                  "description": labelDescription,
                                  "color": labelColor]
            return bodyDictionary
        case .addNewMilestone(let milestoneName, let milestoneDueDate, let milestoneDescription),
             .editExistingMilestone(_, let milestoneName, let milestoneDueDate, let milestoneDescription):
            let bodyDictionary = ["title": milestoneName,
                                  "due_date": milestoneDueDate,
                                  "description": milestoneDescription]
            return bodyDictionary
        case .addAssignee(_, let userID):
            return ["user_id": "\(userID)"]
        case .addComment(_, let content):
            return ["content": content]
        default:
            return nil
        }
    }
}


//
//  BackEndAPIManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import Foundation

class BackEndAPIManager {
        
    // MARK: - Property
    
    private let router: Routable
    
    
    // MARK: - Initializer
    
    init(router: Routable) {
        self.router = router
    }
    
    
    // MARK: - Method
    
    func requestAllIssues(completionHandler: @escaping ((Result<[IssueInfo], APIError>) -> Void)) {
        
        router.request(route: BackEndAPI.allIssues) { (result: Result<[IssueInfo], APIError>) in
            completionHandler(result)
        }
    }
    
    // route: 작성자 or 레이블 or 마일스톤 or 담당자
    func requestDetailCondition<T: Decodable>(route: BackEndAPI, completionHandler: @escaping ((Result<T, APIError>) -> Void)) {
        router.request(route: route) { (result: Result<T, APIError>) in
            completionHandler(result)
        }
    }
    
    func requestFiltering(conditions: FilterInfo, completionHandler: @escaping ((Result<[IssueInfo], APIError>) -> Void)) {
        router.request(route: BackEndAPI.predefinedFilter(query: conditions.description)) { (result: Result<[IssueInfo], APIError>) in
            completionHandler(result)
        }
    }
    
    func requestStatusChange(issueInfo: IssueInfo, status: Status, completionHandler: @escaping ((Result<IssueInfo, APIError>) -> Void)) {
        router.request(route: BackEndAPI.closeIssue(issueNumber: "\(issueInfo.id)", title: issueInfo.title, status: status.rawValue)) { (result: Result<IssueInfo, APIError>) in
            completionHandler(result)
        }
    }
  
}

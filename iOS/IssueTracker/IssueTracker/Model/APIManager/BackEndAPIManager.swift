//
//  BackEndAPIManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import Foundation

class BackEndAPIManager {
    
    static let shared = BackEndAPIManager()
    
    private let router = Router<BackEndAPI>()
    
    
    func requestAllIssues(completionHandler: @escaping ((Result<[IssueInfo], APIError>) -> Void)) {
        router.request(route: .Issues) { (result: Result<[IssueInfo], APIError>) in
            completionHandler(result)
        }
    }
    
    // route: 작성자 or 레이블 or 마일스톤 or 담당자
    func requestDetailCondition<infoType: Decodable>(route: BackEndAPI, completionHandler: @escaping ((Result<infoType, APIError>) -> Void)) {
        router.request(route: route) { (result: Result<infoType, APIError>) in
            
            
        }
    }
    
    func requestFiltering<infoType: Decodable>(conditions: FilterInfo, completionHandler: @escaping ((Result<infoType, APIError>) -> Void)) {
        
        // conditions 파싱 후 .filterIssueList 에 넣어서 보내기
        
        router.request(route: .filterIssueList) { (result: Result<infoType, APIError>) in
            
        }
    }
  
    
}

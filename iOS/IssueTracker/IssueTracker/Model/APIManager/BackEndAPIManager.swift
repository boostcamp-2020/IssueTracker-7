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
    func requestDetailCondition<infoType: Decodable>(route: BackEndAPI, completionHandler: @escaping ((Result<infoType, APIError>) -> Void)) {
        router.request(route: route) { (result: Result<infoType, APIError>) in
            
            
        }
    }
    
    func requestFiltering<infoType: Decodable>(conditions: FilterInfo, completionHandler: @escaping ((Result<infoType, APIError>) -> Void)) {
        
        // conditions 파싱 후 .filterIssueList 에 넣어서 보내기
        
        router.request(route: BackEndAPI.filterIssueList) { (result: Result<infoType, APIError>) in
            
        }
    }
  
    func requestAllLabels(completionHandler: @escaping((Result<[LabelInfo], APIError>) -> Void)) {
        
        router.request(route: BackEndAPI.allLabels) { (result: Result<[LabelInfo], APIError>) in
            completionHandler(result)
        }
    }
    
    func addNewLabel(labelName: String, labelDescription: String, labelColor: String, completionHandler: @escaping((Result<LabelInfo, APIError>) -> Void)) {
        
        router.request(route: BackEndAPI.addNewLabel(labelName: labelName, labelDescription: labelDescription, labelColor: labelColor)) { (result: Result<LabelInfo, APIError>) in
            completionHandler(result)
        }
    }
    
    func editExistingLabel(labelId: Int, labelName: String, labelDescription: String, labelColor: String, completionHandler: @escaping((Result<LabelInfo, APIError>) -> Void)) {
        
        router.request(route: BackEndAPI.editExistingLabel(labelId: labelId, labelName: labelName, labelDescription: labelDescription, labelColor: labelColor)) { (result: Result<LabelInfo, APIError>) in
            completionHandler(result)
        }
    }
}

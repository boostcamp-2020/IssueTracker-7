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
    
    func requestAllMilestones(completionHandler: @escaping ((Result<[MilestoneInfo], APIError>) -> Void)) {
        
        router.request(route: BackEndAPI.allMilestones) { (result: Result<[MilestoneInfo], APIError>) in
            completionHandler(result)
        }
    }
    
    func addNewMilestone(milestoneName: String, milestoneDueDate: String, milestoneDescription: String, completionHandler: @escaping ((Result<MilestoneInfo, APIError>) -> Void)) {
        
        router.request(route: BackEndAPI.addNewMilestone(milestoneName: milestoneName, milestoneDueDate: milestoneDueDate, milestoneDescription: milestoneDescription)) { (result: Result<MilestoneInfo, APIError>) in
            completionHandler(result)
        }
    }
    
    func editExistingMilestone(milestoneId: Int, milestoneName: String, milestoneDueDate: String, milestoneDescription: String, completionHandler: @escaping ((Result<MilestoneInfo, APIError>) -> Void)) {
        
        router.request(route: BackEndAPI.editExistingMilestone(milestoneId: milestoneId, milestoneName: milestoneName, milestoneDueDate: milestoneDueDate, milestoneDescription: milestoneDescription)) { (result: Result<MilestoneInfo, APIError>) in
            completionHandler(result)
        }
    }
}

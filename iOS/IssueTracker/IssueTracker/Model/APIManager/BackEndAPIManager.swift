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
    
    func editExistingMilestone(milestoneId: Int, milestoneName: String, milestoneDueDate: String, milestoneDescription: String, completionHandler: @escaping ((Result<MilestoneInfo, APIError>) -> Void)) {
        
        router.request(route: BackEndAPI.editExistingMilestone(milestoneId: milestoneId, milestoneName: milestoneName, milestoneDueDate: milestoneDueDate, milestoneDescription: milestoneDescription)) { (result: Result<MilestoneInfo, APIError>) in
            completionHandler(result)
        }
    }
    
    func requestPhoto(path: String, completionHandler: @escaping ((Result<Data, APIError>) -> Void)) {
        router.request(route: BackEndAPI.photo(path: path)) { (result: Result<Data, APIError>) in
            
            completionHandler(result)

        }
    }
}

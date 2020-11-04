//
//  IssueData.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/04.
//

import Foundation


struct IssueData: Codable {
    let id: Int
    let title: String
    let status: String
    let createdAt: String
    let updatedAt: String?
    let deletedAt: String?
    let userID: Int?
    let milestoneID: Int?
    let labels: [Label]?
    let assignees: [Assignee]?
    let author: Author?
    let comments: [String]  // TODO: 데이터 뭘로 올지 확실치 않으므로 추후 수정 필요할 수도 있음
    let milestone: Milestone

    enum CodingKeys: String, CodingKey {
        case id, title, status, createdAt, updatedAt, deletedAt
        case userID = "user_id"
        case milestoneID = "milestone_id"
        case labels, assignees, author, comments, milestone
    }
    
    
}

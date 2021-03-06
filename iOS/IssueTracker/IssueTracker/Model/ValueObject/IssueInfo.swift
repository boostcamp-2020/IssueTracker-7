//
//  IssueData.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/04.
//

import Foundation


struct IssueInfo: Codable {
    let id: Int
    let title: String
    var status: String
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
    let userID: Int
    let milestoneID: Int?
    let labels: [LabelInfo]?
    var assignees: [Assignee]?
    let author: Author?
    var comments: [Comment]?
    let milestone: MilestoneInfo?

    enum CodingKeys: String, CodingKey {
        case id, title, status, createdAt, updatedAt, deletedAt
        case userID = "user_id"
        case milestoneID = "milestone_id"
        case labels, assignees, author, comments, milestone
    }
    
    
}

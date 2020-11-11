//
//  MileStoneInfo.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/02.
//

import Foundation

struct MilestonesInfo: Codable {
    let milestones: [MilestoneInfo]
}

// MARK: - Milestone
struct MilestoneInfo: Codable {
    let id: Int
    let title, dueDate, description: String
    let issues: [IssuesInMilestone]
    enum CodingKeys: String, CodingKey {
        case id, title, description, issues
        case dueDate = "due_date"
    }
}

struct IssuesInMilestone: Codable {
    let id: Int
    let title, status: String
}

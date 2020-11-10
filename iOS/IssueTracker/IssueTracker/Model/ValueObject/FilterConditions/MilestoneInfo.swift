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
    let title, dueDate: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case dueDate = "due_date"
    }
}

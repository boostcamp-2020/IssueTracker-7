//
//  MileStoneInfo.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/02.
//

import Foundation

struct MilestonesInfo: Codable {
    let milestones: [Milestone]
}

// MARK: - Milestone
struct Milestone: Codable {
    let id: Int
    let title, dueDate: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case dueDate = "due_date"
    }
}

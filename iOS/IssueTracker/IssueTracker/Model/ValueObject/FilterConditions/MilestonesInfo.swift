//
//  MileStoneInfo.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/02.
//

import Foundation

//{
//    "milestones": [
//        {
//            "id": 1,
//            "title": "1주차",
//            "due_date": "2020-11-03"
//        }
//    ]
//}

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

//
//  Comment.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let content, createdAt, updatedAt: String?
    let userID: Int
    let mentions: Assignee

    enum CodingKeys: String, CodingKey {
        case id, content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userID = "user_id"
        case mentions
    }
}


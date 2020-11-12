//
//  Comment.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let content, updatedAt: String
    let deletedAt, createdAt: String?
    let userID: Int?
    let issueID: Int?
    let mentions: Assignee?

    enum CodingKeys: String, CodingKey {
        case id, content
        case createdAt
        case updatedAt = "updated_at"
        case deletedAt
        case userID = "user_id"
        case issueID = "issue_id"
        case mentions
    }
}

extension Comment: Hashable {
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id
    }
}

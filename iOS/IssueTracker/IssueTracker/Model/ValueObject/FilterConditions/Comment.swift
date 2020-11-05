//
//  Comment.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let content, createdAt, updatedAt: String
    let deletedAt: String?
    let userID, issueID: Int
    let mentions: Mentions

    enum CodingKeys: String, CodingKey {
        case id, content, createdAt, updatedAt, deletedAt
        case userID = "user_id"
        case issueID = "issue_id"
        case mentions
    }
}

struct Mentions: Codable {
    let id: Int
    let userID: String
    let password, photoURL: String?
    let type: String
    let createdAt, updatedAt: String
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case password
        case photoURL = "photo_url"
        case type, createdAt, updatedAt, deletedAt
    }
}

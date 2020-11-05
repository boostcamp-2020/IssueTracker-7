//
//  DetailIssueIfno.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import Foundation

struct DetailIssueInfo: Codable, Hashable {
    let id: Int
    let content: String
    let updateAt: String
    let user: User
    
    static func == (lhs: DetailIssueInfo, rhs: DetailIssueInfo) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id, content
        case updateAt = "update_at"
        case user
    }
}

struct User: Codable, Hashable {
    let id: Int
    let userId: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
    }
}


//
//  AuthorInfo.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/02.
//

import Foundation

// API 명세에 아직 없으므로 추후 수정 필요

struct AuthorsInfo: Codable {
    let authors: [Author]
}

// MARK: - Assignee
struct Author: Codable {
    let id: Int
    let userID: String
    let photoURL: String?
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case photoURL = "photo_url"
        case type
    }
}

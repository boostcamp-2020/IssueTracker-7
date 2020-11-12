//
//  AssigneesInfo.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/02.
//

import Foundation

//{
//   "assignees":[ // <- 아직 API 명세서에 key 이름 미지정하여 추후 변경 필요함
//       {
//           "id":1,
//           "user_id": "camper1"
//       }
//   ]
//}

// MARK: - Welcome
struct AssigneesInfo: Codable {
    let assignees: [Assignee]
}

// MARK: - Assignee
struct Assignee: Codable { // User 로 바꾸기
    let id: Int
    let userID: String
    let photoURL: String?
    let type: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case photoURL = "photo_url"
        case type, createdAt, updatedAt, deletedAt
    }
}

extension Assignee: Hashable {
    static func == (lhs: Assignee, rhs: Assignee) -> Bool {
        return lhs.id == rhs.id
    }
}

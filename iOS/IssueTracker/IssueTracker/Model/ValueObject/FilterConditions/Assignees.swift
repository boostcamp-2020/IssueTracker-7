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
struct Assignee: Codable {
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

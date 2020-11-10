//
//  LabelInfo.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/10.
//

import Foundation

struct LabelInfo: Codable {
    let id: Int
    let name, labelDescription, color: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case labelDescription = "description"
        case color
    }
}

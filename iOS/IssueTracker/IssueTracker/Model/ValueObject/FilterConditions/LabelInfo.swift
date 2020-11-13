//
//  LabelInfo.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/10.
//

import Foundation

struct LabelInfo: Codable {
    let id: Int
    let name, description, color: String
    
    var isSelected: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case description = "description"
        case color
    }
}

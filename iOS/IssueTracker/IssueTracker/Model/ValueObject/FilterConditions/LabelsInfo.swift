//
//  LabelInfo.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/02.
//

import Foundation

//{
//    "labels": [
//        {
//            "id": 1,
//            "name": "frontend",
//            "color": "#000000",
//            "description": ""
//        }
//    ]
//}

// MARK: - Welcome
struct LabelsInfo: Codable {
    let labels: [Label]
}

// MARK: - Label
struct Label: Codable {
    let id: Int
    let name, color, description: String
}


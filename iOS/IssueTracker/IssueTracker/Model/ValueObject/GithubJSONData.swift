//
//  GithubJSONData.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import Foundation

struct GithubJSONData: Decodable {
    enum CodingKeys: String, CodingKey {
        case scope,
             accessToken = "access_token",
             tokenType = "token_type"
    }
    // CamelCase
    let scope: String
    let tokenType: String
    let accessToken: String
}

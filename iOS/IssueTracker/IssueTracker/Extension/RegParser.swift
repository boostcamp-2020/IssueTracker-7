//
//  RegParser.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/03.
//

import Foundation

extension String {
    
    func accessToken() -> String? {
        guard let accessToken = self.checkFormat(by: "(?<=accessToken=)[a-zA-Z0-9._-]+(?=refreshToken=)")?.first else { return nil }
        return accessToken
    }
    
    func refreshToken() -> String? {
        guard let refreshToken = self.checkFormat(by: "(?<=refreshToken=)[a-zA-Z0-9._-]+")?.first else { return nil }
        return refreshToken
    }
    
    func checkFormat(by pattern: String) -> [String]? {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        let result = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return result.map { String(self[Range($0.range, in: self)!]) }
    }
    
}

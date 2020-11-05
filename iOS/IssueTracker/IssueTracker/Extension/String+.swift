//
//  String+.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/05.
//

import Foundation

extension String {
    
    func matchesRegexPattern(_ pattern: String) throws -> Bool {
        
        return try NSRegularExpression(pattern: pattern, options: .caseInsensitive).firstMatch(in: self, options: [], range: _NSRange(location: 0, length: self.count)) == nil
    }
}

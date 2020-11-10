//
//  DetailFilterInfo.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/02.
//

import Foundation


enum Status: String {
    case open = "is:open"
    case close = "is:closed"
}

class FilterInfo {
    
    // 열림/닫힘
    var status: Status?
    
    // 작성자, 마일스톤, 레이블, 담당자
    var author: String?
    var label: String?
    var milestone: String?
    var assignee: String?
    
    func removeAll() {
        status = nil
        author = nil
        label = nil
        milestone = nil
        assignee = nil
    }
}

extension FilterInfo: CustomStringConvertible {
    var description: String {
        var result: [String] = []
        
        if let status = status {
            result.append(status.rawValue)
        }
        
        if let author = author {
            result.append(author)
        }
        
        if let label = label {
            result.append(label)
        }
        
        if let milestone = milestone {
            result.append(milestone)
        }
        
        if let assignee = assignee {
            result.append(assignee)
        }

        return result.joined(separator: "+")
    }
    
    
}

//
//  DetailFilterInfo.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/02.
//

import Foundation


enum Status: String {
    case open = "open"
    case closed = "closed"
}

class FilterInfo {
    
    // 열림/닫힘
    var status: Status?
    var mentions: String = ""
    
    // 작성자, 마일스톤, 레이블, 담당자
    var author: String = ""
    var label: [String] = []
    var milestone: String = ""
    var assignee: String = ""
    
    func removeAll() {
        status = nil
        mentions = ""
        author = ""
        label = []
        milestone = ""
        assignee = ""
    }
}

extension FilterInfo: CustomStringConvertible {
    var description: String {
        var result: [String] = []
        
        if let status = status {
            result.append("is:\(status.rawValue)")
        }
        
        if mentions != "" {
            result.append("mentions:\(mentions)")
        }
        
        if author != "" {
            result.append("author:\(author)")
        }
        
        if label != [] {
            result.append(label.map { "label:\($0)" }.joined(separator: "+"))
        }
        
        if milestone != "" {
            result.append("milestone:\(milestone)")
        }
        
        if assignee != "" {
            result.append("assignee:\(assignee)")
        }

        return result.joined(separator: "+")
    }
    
    
}

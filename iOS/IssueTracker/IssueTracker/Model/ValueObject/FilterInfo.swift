//
//  DetailFilterInfo.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/02.
//

import Foundation

class FilterInfo {
    
    // 열림/닫힘
    var status = ""
    
    // 작성자, 마일스톤, 레이블, 담당자
    var authors: [Author] = []
    var labels: [LabelInfo] = []
    var milestones: [Milestone] = []
    var assignees: [Assignee] = []
}

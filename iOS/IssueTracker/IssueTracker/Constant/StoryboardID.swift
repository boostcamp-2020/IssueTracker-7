//
//  StoryboardName.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/01.
//

import Foundation

/*
[형식]
 1. 스토리보드(.storyboard) 파일 이름
 2. 해당 스토리보드 파일의 storyboard id
 
 */

enum StoryboardID {
    static let main = "Main"
    static let initialTabBarController = "InitialTabBarController"
    
    static let DetailIssueList = "DetailIssueList"
    static let DetailIssueListController = "DetailIssueListController"
    static let userConditionTableViewController = "UserConditionTableViewController"
    static let labelConditionTableViewController = "LabelConditionTableViewController"
    static let mileStoneConditionTableViewController = "MileStoneConditionTableViewController"
    
}

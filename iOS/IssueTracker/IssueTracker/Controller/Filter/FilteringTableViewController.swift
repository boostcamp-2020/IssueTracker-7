//
//  FilteringTableViewController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/29.
//

import UIKit

enum PreSpecifiedCondition: CaseIterable {
    case openIssue
    case myIssue
    case assignedIssue
    case commentedIssue
    case closedIssued
}

protocol SendFilterConditionDelegate: AnyObject {
    func sendPreSpecified(condition: PreSpecifiedCondition) // 미리 지정된 조건 전송
}

class FilteringTableViewController: UITableViewController {
    
    weak var delegate: SendFilterConditionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.section {
        /*
         1. 다음 중에 조건을 고르세요
         열린 이슈들
         내가 작성한 이슈들
         나한테 할당된 이슈들
         내가 댓글을 남긴 이슈들
         닫힌 이슈들
         */
        case 0:
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            
            let condition = PreSpecifiedCondition.allCases[indexPath.row]
            delegate?.sendPreSpecified(condition: condition)
            
        default:
            break
        }
        
    }
}

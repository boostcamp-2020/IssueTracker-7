//
//  FilteringTableViewController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/29.
//

import UIKit

enum Issuecondition {
    case openIssue
    case myIssue
    case assignedIssue
    case commentedIssue
    case closedIssued
}

protocol SendFilterConditionDelegate: AnyObject {
    func send(condition: Issuecondition)
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
            switch indexPath.row {
            case 0:
                delegate?.send(condition: .openIssue)
            case 1:
                delegate?.send(condition: .myIssue)
            case 2:
                delegate?.send(condition: .assignedIssue)
            case 3:
                delegate?.send(condition: .commentedIssue)
            case 4:
                delegate?.send(condition: .closedIssued)
            default:
                break
            }
        default:
            break
        }
        
        
    }
    
}

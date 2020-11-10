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
    var detailFilterInfo: FilterInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    let types: [Codable.Type] = [Author.self, Label.self, Milestone.self, Assignee.self]
    
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
        case 1:
            guard let filterInfo = detailFilterInfo else { return }
            guard let vc = storyboard?.instantiateViewController(identifier: "DetailConditionTableViewController", creator: { coder in
                let route = BackEndAPI.allCases[indexPath.row]
                switch indexPath.row {
                case 0:
                    return DetailConditionTableViewController<Author>(coder: coder, route: route, detailFilterInfo: filterInfo)
                case 1:
                    return DetailConditionTableViewController<Label>(coder: coder, route: route, detailFilterInfo: filterInfo)
                case 2:
                    return DetailConditionTableViewController<MilestoneInfo>(coder: coder, route: route, detailFilterInfo: filterInfo)
                case 3:
                    return DetailConditionTableViewController<Assignee>(coder: coder, route: route, detailFilterInfo: filterInfo)
                default:
                    return nil
                }
            }) else { return }
            
            navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
    
    
    
}


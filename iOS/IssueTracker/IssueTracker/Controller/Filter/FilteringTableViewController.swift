//
//  FilteringTableViewController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/29.
//

import UIKit

enum PredefinedCondition: CaseIterable {
    case openIssue
    case myIssue
    case assignedIssue
    case commentedIssue
    case closedIssued
}


protocol SendFilterConditionDelegate: AnyObject {
    func sendPreSpecified(condition: PredefinedCondition) // 미리 지정된 조건 전송
}

class FilteringTableViewController: UITableViewController {
    
    weak var delegate: SendFilterConditionDelegate?
    var filterInfo: FilterInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    func setUpPredefinedConditions() {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.section {
       
        case 0:
            filterInfo?.removeAll() // 미리 지정된 조건 선택 시 기존 조건들(filterInfo) 모두 초기화
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            
            let condition = PredefinedCondition.allCases[indexPath.row]
            
            switch condition {
            case .openIssue:
                filterInfo?.status = .open
            case .myIssue:
                filterInfo?.author = UserInfo.shared.userName
            case .assignedIssue:
                filterInfo?.assignee = UserInfo.shared.userName
            case .commentedIssue:
                print("지원하지 않음")
            case .closedIssued:
                filterInfo?.status = .close
            }
            delegate?.sendPreSpecified(condition: condition)
        
        
        case 1:
            guard let filterInfo = filterInfo else { return }
            guard let vc = storyboard?.instantiateViewController(identifier: "DetailConditionTableViewController", creator: { coder in
//                let route = BackEndAPI.allCases[indexPath.row]
                switch indexPath.row {
                case 0:
                    return DetailConditionTableViewController<Author>(coder: coder, route: BackEndAPI.allAuthors, detailFilterInfo: filterInfo)
                case 1:
                    return DetailConditionTableViewController<Label>(coder: coder, route: BackEndAPI.allLabels, detailFilterInfo: filterInfo)
                case 2:
                    return DetailConditionTableViewController<Milestone>(coder: coder, route: BackEndAPI.allMilestones, detailFilterInfo: filterInfo)
                case 3:
                    return DetailConditionTableViewController<Assignee>(coder: coder, route: BackEndAPI.allAssignees, detailFilterInfo: filterInfo)
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


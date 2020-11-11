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
    func sendPredefined(condition: PredefinedCondition)
}

final class FilteringTableViewController: UITableViewController {
    
    // MARK: - Property
    
    weak var delegate: SendFilterConditionDelegate?
    var filterInfo: FilterInfo?
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Extension

extension FilteringTableViewController {
    
    // MARK: TableView
    
    func detailConditions(at indexPath: IndexPath) {
        guard let filterInfo = filterInfo else { return }

        var viewController: UIViewController?
        switch indexPath.row {
        case 0:
            viewController = storyboard?.instantiateViewController(
                identifier: StoryboardID.userConditionTableViewController,
                creator: { coder in
                return UserConditionTableViewController(
                    coder: coder,
                    route: BackEndAPI.allAuthors,
                    filterInfo: filterInfo)
            })
        case 1:
            viewController = storyboard?.instantiateViewController(
                identifier: StoryboardID.labelConditionTableViewController,
                creator: { coder in
                return LabelConditionTableViewController(
                    coder: coder,
                    route: BackEndAPI.allLabels,
                    filterInfo: filterInfo)
            })
        case 2:
            viewController = storyboard?.instantiateViewController(
                identifier: StoryboardID.mileStoneConditionTableViewController,
                creator: { coder in
                return MileStoneConditionTableViewController(
                    coder: coder,
                    route: BackEndAPI.allMilestones,
                    filterInfo: filterInfo)
            })
        case 3:
            viewController = storyboard?.instantiateViewController(
                identifier: StoryboardID.userConditionTableViewController,
                creator: { coder in
                return UserConditionTableViewController(
                    coder: coder,
                    route: BackEndAPI.allAssignees,
                    filterInfo: filterInfo)
            })
        default:
            break
        }
        
        if let viewController = viewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func predefinedConditions(at indexPath: IndexPath) {
        // 미리 지정된 조건 선택 시 기존 조건들(filterInfo) 모두 초기화
        filterInfo?.removeAll()
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        let condition = PredefinedCondition.allCases[indexPath.row]
        
        switch condition {
        case .openIssue:
            filterInfo?.status = .open
        case .myIssue:
            filterInfo?.author = "@me"
        case .assignedIssue:
            filterInfo?.assignee = "@me"
        case .commentedIssue:
            filterInfo?.mentions = "@me"
        case .closedIssued:
            filterInfo?.status = .closed
        }
        delegate?.sendPredefined(condition: condition)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            predefinedConditions(at: indexPath)
        case 1:
            detailConditions(at: indexPath)
        default:
            break
        }
    }
}


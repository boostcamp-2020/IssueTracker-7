//
//  FilteringController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/29.
//

import UIKit

class FilteringController: UIViewController {
    
    var filterInfo = FilterInfo()
    var preDefinedConditionHandler: ((FilterInfo)->())?
    var detailConditionHandler: ((FilterInfo)->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilteringTableView" {
            guard let childVc = segue.destination as? FilteringTableViewController else { return }
            childVc.delegate = self
            childVc.detailFilterInfo = filterInfo
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        print(filterInfo.assignees)
        if let handler = detailConditionHandler {
            handler(filterInfo)
        }
        dismiss(animated: true)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension FilteringController: SendFilterConditionDelegate {
    func sendPreSpecified(condition: PreSpecifiedCondition) {
        print(condition)
        if let handler = preDefinedConditionHandler {
            handler(filterInfo)
        }
        dismiss(animated: true)
    }
}

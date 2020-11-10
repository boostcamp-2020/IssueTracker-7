//
//  FilteringController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/29.
//

import UIKit

class FilteringController: UIViewController {
    
    var filterInfo: FilterInfo?
    var preDefinedConditionHandler: ((FilterInfo)->())?
    var detailConditionHandler: ((FilterInfo)->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilteringTableView" {
            guard let childVc = segue.destination as? FilteringTableViewController else { return }
            childVc.delegate = self
            childVc.filterInfo = filterInfo
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        if let handler = detailConditionHandler, let filterInfo = filterInfo {
            handler(filterInfo)
        }
        dismiss(animated: true)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension FilteringController: SendFilterConditionDelegate {
    func sendPreSpecified(condition: PredefinedCondition) {
        dismiss(animated: false)

        if let handler = preDefinedConditionHandler, let filterInfo = filterInfo {
            handler(filterInfo)
        }
    }
}

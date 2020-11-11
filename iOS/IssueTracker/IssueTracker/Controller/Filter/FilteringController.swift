//
//  FilteringController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/29.
//

import UIKit

final class FilteringController: UIViewController {
    
    // MARK: - Property
    
    var filterInfo: FilterInfo?
    var predefinedConditionHandler: ((FilterInfo)->())?
    var detailConditionHandler: ((FilterInfo)->())?
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilteringTableView" {
            guard let destionationViewController = segue.destination as? FilteringTableViewController else { return }
            destionationViewController.delegate = self
            destionationViewController.filterInfo = filterInfo
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
    func sendPredefined(condition: PredefinedCondition) {
        if let handler = predefinedConditionHandler, let filterInfo = filterInfo {
            handler(filterInfo)
        }
        dismiss(animated: true)
    }
}

//
//  FilteringController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/29.
//

import UIKit

class FilteringController: UIViewController {
    
    let detailFilterInfo = DetailFilterInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilteringTableView" {
            guard let childVc = segue.destination as? FilteringTableViewController else { return }
            childVc.delegate = self
            childVc.detailFilterInfo = detailFilterInfo
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        // SignInController 로 세부 조건 전달
        print(detailFilterInfo)
        dismiss(animated: true)
        
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension FilteringController: SendFilterConditionDelegate {
    // 선택한 조건 수신 시 바로 화면 dismiss
    func sendPreSpecified(condition: PreSpecifiedCondition) {
        print(condition)
        dismiss(animated: true)
    }
}

//
//  FilteringController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/29.
//

import UIKit

class FilteringController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        // SignInController 로 세부 조건 전달
        dismiss(animated: true)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

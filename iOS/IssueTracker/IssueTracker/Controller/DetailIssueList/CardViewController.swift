//
//  ReactionViewController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/03.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var handle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handle.layer.masksToBounds = true
        handle.layer.cornerRadius = 3
    }
}

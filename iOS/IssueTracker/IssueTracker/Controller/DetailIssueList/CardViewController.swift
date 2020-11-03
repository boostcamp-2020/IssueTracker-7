//
//  ReactionViewController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/03.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var handle: UIView!
    @IBOutlet weak var commentStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handle.layer.masksToBounds = true
        handle.layer.cornerRadius = 3
        
        commentStack.translatesAutoresizingMaskIntoConstraints = false
        commentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        commentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        commentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        
    }
}

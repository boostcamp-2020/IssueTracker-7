//
//  CardViewController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/12.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var handle: UIView!
    @IBOutlet weak var commentAddBtn: UIButton!
    @IBOutlet weak var commentUpDownStackView: UIStackView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    func setUpViews() {
        handle.layer.cornerRadius = 5
        
        commentAddBtn.setUpShadow()
        commentAddBtn.layer.cornerRadius = 5

        baseView.backgroundColor = UIColor.clear
        baseView.setUpShadow()
        
        commentUpDownStackView.layer.masksToBounds = true
        commentUpDownStackView.layer.cornerRadius = 5
        
        closeButton.setUpShadow()
        closeButton.layer.cornerRadius = 5
    }



}

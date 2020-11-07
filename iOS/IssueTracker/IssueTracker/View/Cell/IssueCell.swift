//
//  IssueCell.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import UIKit

final class IssueCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let reuseIdentifier = String(describing: IssueCell.self)
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpView()
    }

    // MARK: - Method
    
    override func prepareForReuse() {
        visibleView.initLabels()
    }
    }
    
    private func setUpView() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }

    func configure(issueData: IssueData) {
        visibleView.configure(issueData: issueData)
    }
}



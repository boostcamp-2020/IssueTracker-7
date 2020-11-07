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
    
    // For swipe
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.frame = bounds
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private var visibleView: IssueCellContentView!
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpSwipable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpView()
        setUpSwipable()
    }

    // MARK: - Method
    
    override func prepareForReuse() {
        visibleView.initLabels()
    }
    
    private func setUpSwipable() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.pinEdgesToSuperView()
        stackView.pinEdgesToSuperView()
        
        visibleView = IssueCellContentView()
        
        let hiddenView = UIView()
        hiddenView.backgroundColor = UIColor.blue
        
        let hiddenView2 = UIView()
        hiddenView2.backgroundColor = UIColor.systemRed
        
        stackView.addArrangedSubview(visibleView)
        stackView.addArrangedSubview(hiddenView)
        stackView.addArrangedSubview(hiddenView2)
        
        
        visibleView.translatesAutoresizingMaskIntoConstraints = false
        hiddenView.translatesAutoresizingMaskIntoConstraints = false
        hiddenView2.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.4),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            visibleView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            hiddenView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.2),
            hiddenView2.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func setUpView() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }

    func configure(issueData: IssueData) {
        visibleView.configure(issueData: issueData)
    }
}



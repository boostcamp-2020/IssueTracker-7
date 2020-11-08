//
//  IssueCell.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import UIKit

protocol IssueCellDelegate: AnyObject {
    func issueListDidInteracted(cell: IssueCell)
    func issueListDidTapped(cell: IssueCell)
}

final class IssueCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let reuseIdentifier = String(describing: IssueCell.self)
    weak var delegate: IssueCellDelegate?
    
    // For swipe
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .systemRed
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private let visibleView = IssueCellContentView()
    private var closeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGreen
        return view
    }()
    private var deleteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemRed
        return view
    }()
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView.delegate = self
        setUpView()
        setUpSwipable()
        setUpTapGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        scrollView.delegate = self
        setUpView()
        setUpSwipable()
        setUpTapGesture()
    }

    // MARK: - Method
    
    override func prepareForReuse() {
        visibleView.initLabels()
    }
    
    private func setUpTapGesture() {
        let visibleRecognizer = UITapGestureRecognizer(target: self, action: #selector(contentTapped))
        visibleView.addGestureRecognizer(visibleRecognizer)
        
        let closeRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeIssue))
        closeView.addGestureRecognizer(closeRecognizer)
        
        let deleteRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteIssue))
        deleteView.addGestureRecognizer(deleteRecognizer)
    }
    
    @objc private func contentTapped() {
        delegate?.issueListDidTapped(cell: self)
        delegate?.issueListDidInteracted(cell: self)
    }
    
    @objc private func closeIssue() {
        print("close")
    }
    
    
    @objc private func deleteIssue() {
        print("delete")
    }
    
    private func setUpSwipable() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.pinEdgesToSuperView()
        stackView.pinEdgesToSuperView()
                
        stackView.addArrangedSubview(visibleView)
        stackView.addArrangedSubview(closeView)
        stackView.addArrangedSubview(deleteView)
        
        visibleView.translatesAutoresizingMaskIntoConstraints = false
        closeView.translatesAutoresizingMaskIntoConstraints = false
        deleteView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.4),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            visibleView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            closeView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.2),
            deleteView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.2)
        ])
        
        addImage(view: closeView, imageName: "xmark.rectangle")
        addImage(view: deleteView, imageName: "trash")
    }
    
    func addImage(view: UIView, imageName: String) {
        let image = UIImage(systemName: imageName)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setUpView() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }

    func configure(issueData: IssueData) {
        visibleView.configure(issueData: issueData)
    }
    
    func resetOffset() {
        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.scrollView.contentOffset.x = 0
        }.startAnimation()
    }
    
    func isSwiped() -> Bool {
        scrollView.contentOffset.x != 0
    
    
}


// MARK: - Extension

extension IssueCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= 0 {
            scrollView.contentOffset.x = 0
            scrollView.bounces = false
        } else {
            scrollView.bounces = true
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.issueListDidInteracted(cell: self)
    }
}





//
//  AssigneesProfileStackView.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/12.
//

import UIKit

final class AssigneesProfileStackView: UIStackView {
    
    // MARK: - Property
    
    let maxProfileImageInLine = 4
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Method
    
    func initializeView() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func fillEmptySpace(of assignees: [Assignee?]) -> [Assignee?] {
        var assignees = assignees
        (0..<(maxProfileImageInLine - (assignees.count % 4))).forEach { _ in
            assignees.append(nil)
        }
        return assignees
    }
    
    func stackView(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = 10
        
        return stackView
    }
    
    func configure(by assignees: [Assignee?]) {
        
        let filledAssignees = fillEmptySpace(of: assignees)
        
        var multipleStackView = stackView(axis: .horizontal, distribution: .fillEqually)
        
        filledAssignees.enumerated().forEach { (index, assignee) in
            
            if index % maxProfileImageInLine == 0 && index != 0 {
                addArrangedSubview(multipleStackView)
                multipleStackView = stackView(axis: .horizontal, distribution: .fillEqually)
            }
            
            let profileInfoStackView = stackView(axis: .vertical)
            
            // 1. 담당자 이미지 추가
            let profileImageView = UIImageView()
            profileImageView.layer.cornerRadius = 10
            profileImageView.layer.masksToBounds = true
            if let data = assignee?.data { profileImageView.image = UIImage(data: data) }
            
            profileInfoStackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                profileImageView.widthAnchor.constraint(equalToConstant: 70),
                profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor)
            ])
            
            profileImageView.backgroundColor = UIColor.clear
            profileInfoStackView.addArrangedSubview(profileImageView)
            
            // 2. 담당자 아이디 추가
            let idLabel = UILabel()
            idLabel.font = .systemFont(ofSize: 10)
            idLabel.textAlignment = .center
            idLabel.text = assignee?.userID
            profileInfoStackView.addArrangedSubview(idLabel)
            
            multipleStackView.addArrangedSubview(profileInfoStackView)
        }
        addArrangedSubview(multipleStackView)
    }
}

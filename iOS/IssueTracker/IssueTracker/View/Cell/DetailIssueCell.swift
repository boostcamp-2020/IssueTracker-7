//
//  DetailIssueCell.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import UIKit

final class DetailIssueHeader: UICollectionReusableView {
    
    static let reuseIdentifier = String(describing: DetailIssueHeader.self)
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var issueNumber: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    static func configureCell(cell: DetailIssueHeader, issueInfo: IssueInfo, imageData: Data?) {
        
        cell.issueNumber.text = "#\(issueInfo.id)"
        cell.userId.text = issueInfo.comments?.first?.mentions?.userID ?? "아이디 없음"
        cell.title.text = issueInfo.title
        if let imageData = imageData {
            cell.profileImage.image = UIImage(data: imageData)
        }
        
    }
}


final class DetailIssueCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let reuseIdentifier = String(describing: DetailIssueCell.self)
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var content: UILabel!
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    // MARK: - Method
    
    override func prepareForReuse() {
//        profileImage.image = nil
    }
    
    static func configureCell(cell: DetailIssueCell, commentInfo: Comment, imageData: Data?) {
        
        cell.userId.text = commentInfo.mentions?.userID ?? "아이디 없음"
        cell.time.text = commentInfo.updatedAt
        cell.content.text = commentInfo.content
        if let imageData = imageData {
            cell.profileImage.image = UIImage(data: imageData)
        }
    }
}

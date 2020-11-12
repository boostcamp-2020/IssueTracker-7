//
//  DetailIssueCell.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import UIKit

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
    
    static func configureCell(cell: DetailIssueCell, commentInfo: Comment, imageData: Data?) {
        
        cell.userId.text = commentInfo.mentions?.userID ?? "아이디 없음"
        cell.time.text = commentInfo.updatedAt
        cell.content.text = commentInfo.content
        if let imageData = imageData {
            cell.profileImage.image = UIImage(data: imageData)
        }
    }
}

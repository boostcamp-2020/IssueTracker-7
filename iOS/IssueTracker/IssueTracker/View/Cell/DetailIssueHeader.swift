//
//  DetailIssueHeader.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/12.
//

import UIKit

final class DetailIssueHeader: UICollectionReusableView {
    
    static let reuseIdentifier = String(describing: DetailIssueHeader.self)
    @IBOutlet private weak var userId: UILabel!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var issueNumber: UILabel!
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var status: UIButton!
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    // MARK: - Method
    
    private static func changeStatus(cell: DetailIssueHeader, status: String, imageName: String, color: UIColor) {
        
        cell.status.setTitle(" \(status)", for: .normal)
        cell.status.setImage(UIImage(systemName: imageName), for: .normal)
        cell.status.backgroundColor = color
    }
    
    static func configureCell(cell: DetailIssueHeader, issueInfo: IssueInfo, imageData: Data?) {
        
        cell.issueNumber.text = "#\(issueInfo.id)"
        cell.userId.text = issueInfo.comments?.first?.mentions?.userID ?? "아이디 없음"
        cell.title.text = issueInfo.title
        if issueInfo.status == "open" {
            changeStatus(
                cell: cell,
                status: "Open",
                imageName: "exclamationmark.circle",
                color: UIColor.systemGreen)
        } else {
            changeStatus(
                cell: cell,
                status: "Closed",
                imageName: "xmark.circle",
                color: UIColor.systemRed)
        }
        
        if let imageData = imageData {
            cell.profileImage.image = UIImage(data: imageData)
        }
    }
}

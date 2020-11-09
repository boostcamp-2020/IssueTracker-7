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
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    static func configureCell(cell: DetailIssueHeader, data: HeaderDetailIssueInfo) {
        
        cell.issueNumber.text = "\(data.issueNumber)"
        cell.userId.text = "\(data.userId)"
        cell.title.text = data.title
    }
}


final class DetailIssueCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: DetailIssueCell.self)
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var content: UITextView!
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    static func configureCell(cell: DetailIssueCell, data: DetailIssueInfo) {
        
        cell.userId.text = "sample_id2"
        
    }
    
}

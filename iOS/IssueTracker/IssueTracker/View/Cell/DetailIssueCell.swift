//
//  DetailIssueCell.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import UIKit

final class DetailIssueTopCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: DetailIssueTopCell.self)
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
    
    static func configureCell(cell: DetailIssueTopCell, data: DetailIssueInfo) {
        
        cell.userId.text = "sampleId"
        cell.title.text = "곧 완성될 제목"
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

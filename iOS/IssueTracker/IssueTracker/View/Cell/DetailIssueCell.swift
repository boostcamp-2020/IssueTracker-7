//
//  DetailIssueCell.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import UIKit

final class DetailIssueCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: DetailIssueCell.self)
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    static func configureCell(cell: DetailIssueCell, data: String) {
        
        cell.label.text = data
        
    }
    
}

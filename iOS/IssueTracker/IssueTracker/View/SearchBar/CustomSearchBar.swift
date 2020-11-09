//
//  CustomSearchBar.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import UIKit

class CustomSearchBar: UICollectionReusableView {
    
    // MARK: - Property
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Method
    
    override func awakeFromNib() {
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search"
    }

}

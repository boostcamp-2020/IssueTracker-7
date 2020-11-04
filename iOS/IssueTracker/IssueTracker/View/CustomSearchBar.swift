//
//  CustomSearchBar.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import UIKit

class CustomSearchBar: UICollectionReusableView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        
    }
    
    override func awakeFromNib() {
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search"
    }

}

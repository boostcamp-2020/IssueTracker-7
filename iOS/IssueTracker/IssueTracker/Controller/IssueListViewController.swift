//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/10/29.
//

import UIKit

final class IssueListViewController: UIViewController {

    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

    }
}

extension IssueListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueCell.reuseIdentifier, for: indexPath) as! IssueCell
        return cell
    }
}

extension IssueListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 100 )
    }
}

extension IssueListViewController: UICollectionViewDelegate {
    
}

final class IssueCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: IssueCell.self)
    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!
    @IBOutlet var milestone: UIButton!
    @IBOutlet var label: UIButton!
    
}

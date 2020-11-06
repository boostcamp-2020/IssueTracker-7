//
//  ViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/03.
//

import UIKit

final class ManageLabelViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        
        configureLayout()
    }
}

extension ManageLabelViewController {
    
    private func configureLayout() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: view.bounds.size.width, height: 65)
        collectionViewFlowLayout.minimumLineSpacing = 1
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }
}

extension ManageLabelViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCell.reuseIdentifier, for: indexPath) as! LabelCell
        // 각 cell을 터치했을 때 편집
        return cell
    }
}

final class LabelCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: LabelCell.self)
    @IBOutlet var type: UIButton!
    @IBOutlet var information: UILabel!
    
}

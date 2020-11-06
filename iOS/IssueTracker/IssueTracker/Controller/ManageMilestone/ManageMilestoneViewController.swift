//
//  ManageMilestoneViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/05.
//

import UIKit

final class ManageMilestoneViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        
        configureLayout()
    }
    
}

// MARK: - Layout

extension ManageMilestoneViewController {
    
    private func configureLayout() {
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: view.bounds.size.width, height: 77)
        collectionViewFlowLayout.minimumLineSpacing = 1
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }
}

// MARK: - DataSource

extension ManageMilestoneViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MilestoneCell.reuseIdentifier, for: indexPath)
        // TODO: 각 cell을 터치했을 때 편집화면으로 이동해야한다.
        return cell
    }
}

// MARK: - MilestoneCell

final class MilestoneCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: MilestoneCell.self)
    @IBOutlet var name: UIButton!
    @IBOutlet var dueDate: UILabel!
    @IBOutlet var percentComplete: UILabel!
    @IBOutlet var info: UILabel!
    @IBOutlet var openIssueCount: UILabel!
    @IBOutlet var closedIssueCount: UILabel!
}

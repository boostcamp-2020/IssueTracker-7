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
<<<<<<< Updated upstream
        collectionView.delegate = self
        
        collectionView.layoutIfNeeded()
        configureLayout()
        
    }
}

<<<<<<< Updated upstream
extension IssueListViewController {
    private func configureLayout() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: collectionView.bounds.size.width, height: 100)
        collectionViewFlowLayout.minimumLineSpacing = 2
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = collectionViewFlowLayout
=======
=======
        
        configureLayout()
    }
}

extension IssueListViewController {
    private func configureLayout() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: view.bounds.size.width, height: 100)
        collectionViewFlowLayout.minimumLineSpacing = 1
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = collectionViewFlowLayout
>>>>>>> Stashed changes
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
extension IssueListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 100 )
    }
}

>>>>>>> Stashed changes
extension IssueListViewController: UICollectionViewDelegate {
    
}

=======
>>>>>>> Stashed changes
final class IssueCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: IssueCell.self)
    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!
    @IBOutlet var milestone: UIButton!
    @IBOutlet var label: UIButton!
    
}

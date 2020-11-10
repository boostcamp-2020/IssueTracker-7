//
//  ViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/03.
//

import UIKit

final class ManageLabelViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    private var labelDataList: [LabelInfo] = []
    private let api = BackEndAPIManager(router: Router())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabelData()
        configureLayout()
        collectionView.dataSource = self
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
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCell.reuseIdentifier, for: indexPath) as! LabelCell
        // 각 cell을 터치했을 때 편집
        cell.configure(labelData: labelDataList[indexPath.row])
        return cell
    }
}

extension ManageLabelViewController {
    
    fileprivate func setUpLabelData() {
        api.requestAllLabels() { result in
            switch result {
            case .success(let labels):
                print("helloLabels", labels)
                self.labelDataList = labels
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

final class LabelCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: LabelCell.self)
    @IBOutlet var name: UIButton!
    @IBOutlet var labelDescription: UILabel!
    
    func configure(labelData: LabelInfo) {
        
        name.setTitle(" \(labelData.name) ", for: .normal)
        name.backgroundColor = UIColor.init(hex: labelData.color)
        labelDescription.text = labelData.description
    }
}

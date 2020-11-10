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
        collectionView.delegate = self
    }
}

extension ManageLabelViewController {
    
    private func configureLayout() {
        let spacing: CGFloat = 10
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: collectionView.bounds.size.width - 30, height: 85)
        collectionViewFlowLayout.minimumLineSpacing = spacing
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }
}

extension ManageLabelViewController: UICollectionViewDataSource {
    
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
    
    private func setUpLabelData() {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "ManageLabel", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ManageLabelModalViewController") as! ManageLabelModalViewController
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        viewController.labelInfo = labelDataList[indexPath.item]
        
        present(viewController, animated: true, completion: nil)
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

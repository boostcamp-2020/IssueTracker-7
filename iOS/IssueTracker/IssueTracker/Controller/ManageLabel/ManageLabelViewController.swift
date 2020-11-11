//
//  ViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/03.
//

import UIKit

final class ManageLabelViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    private let api = BackEndAPIManager(router: Router())
    var labelDataList: [LabelInfo] = []
    
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
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: spacing, right: 0)
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "ManageLabel", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ManageLabelModalViewController") as! ManageLabelModalViewController
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        viewController.labelInfo = labelDataList[indexPath.item]
        viewController.delegate = self
        
        present(viewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ModalViewControllerSegue" {
            let modalViewController: ManageLabelModalViewController = segue.destination as! ManageLabelModalViewController
            modalViewController.delegate = self
        }
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

extension ManageLabelViewController: ManageLabelModalViewDelegate {
    
    func addNewLabel(label: LabelInfo) {
        
        labelDataList.append(label)
        
        let lastItemIndex = self.collectionView(self.collectionView, numberOfItemsInSection: 0) - 1
        let lastItemIndexPath = IndexPath(item: lastItemIndex, section: 0)
        
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [lastItemIndexPath])
        } completion: { _ in
            self.collectionView.scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
        }

    }
    
    func updateLabel(label: LabelInfo) {
        
        guard let selectedItemIndex = labelDataList.firstIndex(where: { $0.id == label.id }) else { return }
        labelDataList[selectedItemIndex] = label
        let selectedItemIndexPath = IndexPath(item: selectedItemIndex, section: 0)
        
        collectionView.performBatchUpdates {
            collectionView.reloadItems(at: [selectedItemIndexPath])
        } completion: { _ in
            self.collectionView.scrollToItem(at: selectedItemIndexPath, at: .bottom, animated: true)
        }

        
    }
}

extension ManageLabelViewController {
    
    private func setUpLabelData() {
        api.requestAllLabels() { result in
            switch result {
            case .success(let labels):
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
        
        addShadow()
    }
    
    private func addShadow () {
        let radius: CGFloat = 10
        layer.cornerRadius = radius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}


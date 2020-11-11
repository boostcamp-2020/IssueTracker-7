//
//  ManageMilestoneViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/05.
//

import UIKit

final class ManageMilestoneViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    private var milestoneDataList: [MilestoneInfo] = []
    private let api = BackEndAPIManager(router: Router())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMilestoneData()
        configureLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - Layout

extension ManageMilestoneViewController {
    
    private func configureLayout() {
        
        let spacing: CGFloat = 10
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: collectionView.bounds.size.width - 30, height: 85)
        collectionViewFlowLayout.minimumLineSpacing = spacing
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }
}

// MARK: - DataSource

extension ManageMilestoneViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return milestoneDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MilestoneCell.reuseIdentifier, for: indexPath) as! MilestoneCell
        // TODO: 각 cell을 터치했을 때 편집화면으로 이동해야한다.
        cell.configure(milestoneData: milestoneDataList[indexPath.row])
        return cell
    }
}

extension ManageMilestoneViewController: ManageMilestoneModalViewDelegate {
    
    func addNewMilestone(milestone: MilestoneInfo) {
        
        milestoneDataList.append(milestone)
        
        let lastItemIndex = self.collectionView(self.collectionView, numberOfItemsInSection: 0) - 1
        let lastItemIndexPath = IndexPath(item: lastItemIndex, section: 0)
        
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [lastItemIndexPath])
        } completion: { _ in
            self.collectionView.scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
        }

    }
    
    func updateMilestone(milestone: MilestoneInfo) {
        
        guard let selectedItemIndex = milestoneDataList.firstIndex(where: { $0.id == milestone.id }) else { return }
        milestoneDataList[selectedItemIndex] = milestone
        let selectedItemIndexPath = IndexPath(item: selectedItemIndex, section: 0)
        
        collectionView.performBatchUpdates {
            collectionView.reloadItems(at: [selectedItemIndexPath])
        } completion: { _ in
            self.collectionView.scrollToItem(at: selectedItemIndexPath, at: .bottom, animated: true)
        }

        
    }
}

extension ManageMilestoneViewController {
    
    private func setUpMilestoneData() {
        api.requestAllMilestones() { result in
            switch result {
            case .success(let milestones):
                self.milestoneDataList = milestones
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "ManageMilestone", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ManageMilestoneModalViewController") as! ManageMilestoneModalViewController
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        viewController.milestoneInfo = milestoneDataList[indexPath.item]
        viewController.delegate = self
        
        present(viewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ManageMilestoneModalViewControllerSegue" {
            let modalViewController: ManageMilestoneModalViewController = segue.destination as! ManageMilestoneModalViewController
            modalViewController.delegate = self
        }
    }
}

// MARK: - MilestoneCell

final class MilestoneCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: MilestoneCell.self)
    @IBOutlet var name: UIButton!
    @IBOutlet var dueDate: UILabel!
    @IBOutlet var percentComplete: UILabel!
    @IBOutlet var milestoneDescription: UILabel!
    @IBOutlet var openIssueCount: UILabel!
    @IBOutlet var closedIssueCount: UILabel!
        
    fileprivate func configure(milestoneData: MilestoneInfo) {
        
        name.setTitle(milestoneData.title, for: .normal)
        dueDate.text = milestoneData.dueDate
        milestoneDescription.text = milestoneData.description
        addShadow()
    }
    
    private func addShadow() {
        let radius: CGFloat = 10
        layer.cornerRadius = radius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

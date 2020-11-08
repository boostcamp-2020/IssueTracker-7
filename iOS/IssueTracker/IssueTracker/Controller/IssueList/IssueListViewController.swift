//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/10/29.
//

import UIKit

enum barButtonItemState: String {
    case selectAll = "전체 선택",
         deselectAll = "전체 선택 해제",
         edit = "편집",
         done = "완료"
}

final class IssueListViewController: UIViewController {
    
    // MARK: - Property
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet var filterButtonItem: UIBarButtonItem!
    
    private var issueDataList: [IssueData] = []
    
    private lazy var selectAllButtonItem: UIBarButtonItem = UIBarButtonItem(title: barButtonItemState.selectAll.rawValue, style: .plain, target: self, action: #selector(pressedSelectAllButton))
    
    private var selectAllActive: Bool = false {
        didSet {
            if selectAllActive {
                navigationItem.leftBarButtonItem!.title = barButtonItemState.deselectAll.rawValue
                selectAllItems()
            } else {
                navigationItem.leftBarButtonItem!.title = barButtonItemState.selectAll.rawValue
                deselectAllItems()
            }
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpIssueData()
        collectionView.layoutIfNeeded()
        configureLayout()
        configureNavigationBarButtonItem()
    }
    
    // MARK: - Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IssueListToFilter" {
            guard let navigationController = segue.destination as? UINavigationController,
                  let viewController = navigationController.topViewController as? FilteringController
            else { return }
            
            viewController.preDefinedConditionHandler = { conditions in
                //                BackEndAPIManager.shared.requestFiltering(conditions: conditions) { (result: Result<이슈목록Decodable객체, APIError>) in
                //
                //                }
                print("predefinedConditionHandler") //
            }
            viewController.detailConditionHandler = { conditions in
                //                BackEndAPIManager.shared.requestFiltering(conditions: conditions) { (result: Result<이슈목록Decodable객체, APIError>) in
                //
                //                }
                print("detailConditionHandler")
            }
        }
    }
}


// MARK: - Extension

extension IssueListViewController {
    
    private func setUpIssueData() {
        BackEndAPIManager.shared.requestAllIssues() { result in
            switch result {
            case .success(let issues):
                self.issueDataList = issues
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureLayout() {
        let spacing: CGFloat = 10
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: collectionView.frame.width-30, height: 50)
        collectionViewFlowLayout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: 50)
        collectionViewFlowLayout.minimumLineSpacing = spacing
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }
}

extension IssueListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return issueDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueCell.reuseIdentifier, for: indexPath) as! IssueCell
        cell.delegate = self
        cell.configure(issueData: issueDataList[indexPath.row])
        cell.isEditing = isEditing
        
        // cell을 reuse하기 전에 cell이 selected items에 포함된다면 selected 표시 -- selected된 cell이 reuse 되면서 selected state가 유지되는 버그를 수정함
        if collectionView.indexPathsForSelectedItems!.contains(indexPath) {
            cell.isSelected = true
        }
        
        return cell
    }
}

extension IssueListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if isEditing {
            setNavigationTitle()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing {
            setNavigationTitle()
            print("selected item")
        } 
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "searchBarHeader",
            for: indexPath)
        
        return headerView

    }
}

extension IssueListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("입력")
    }
}

extension IssueListViewController: IssueCellDelegate {
    
    func issueListDidInteracted(cell: IssueCell) {
        guard let visibleCells = collectionView.visibleCells as? [IssueCell] else { return }
        visibleCells.forEach { visibleCell in
            if  visibleCell.isSwiped() {
                visibleCell.resetOffset()
            }
        }
    }
    
    func issueListDidTapped(cell: IssueCell) {
        
        guard let visibleCells = collectionView.visibleCells as? [IssueCell] else { return }
        for visibleCell in visibleCells {
            if visibleCell.isSwiped() { return }
        }
        
        let storyboard = UIStoryboard(name: "DetailIssueList", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "DetailIssueListController")
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension IssueListViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let visibleCells = collectionView.visibleCells as? [IssueCell] else { return }
        visibleCells.forEach { visibleCell in
            if !visibleCell.isEditing {
                visibleCell.resetOffset()
            }
        }
    }
}

// MARK: - Select/Deselect

extension IssueListViewController {
    
    private func configureNavigationBarButtonItem() {
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem?.title = barButtonItemState.edit.rawValue
    }
    
    private func selectAllItems() {
        
        (0..<collectionView!.numberOfItems(inSection: 0)).forEach { itemIndex in
            let indexPath = IndexPath(item: itemIndex, section: 0)
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    private func deselectAllItems() {
        
        guard let selectedItems = collectionView.indexPathsForSelectedItems else { return }
        selectedItems.forEach { indexPath in
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    
    @IBAction func pressedCloseSelectedItems(_ sender: UIBarButtonItem) {
        guard let selectedItems = collectionView.indexPathsForSelectedItems else { return }
        print("close selected issues")
        // TODO: close issues with selected items here
    }
    
    @objc private func pressedSelectAllButton() {
        selectAllActive = !selectAllActive
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing
        // deselect any selected items when edit mode turns on
        collectionView.indexPathsForSelectedItems?.forEach { indexPath in
            collectionView.deselectItem(at: indexPath, animated: false)
        }
        
        // turn on edit mode for each visible cells
        collectionView.indexPathsForVisibleItems.forEach { indexPath in
            let cell = collectionView.cellForItem(at: indexPath) as! IssueCell
            cell.isEditing = editing
        }
        
        if editing {
            navigationItem.rightBarButtonItem?.title = barButtonItemState.done.rawValue
            tabBarController?.tabBar.isHidden = editing
            navigationItem.leftBarButtonItem = selectAllButtonItem
            setNavigationTitle()
        } else {
            navigationItem.rightBarButtonItem?.title = barButtonItemState.edit.rawValue
            tabBarController?.tabBar.isHidden = editing
            selectAllActive = editing
            navigationItem.leftBarButtonItem = filterButtonItem
            setNavigationTitle()
        }
    }
    
    private func setNavigationTitle() {
        
        if let selectedItemCount = collectionView.indexPathsForSelectedItems?.count, selectedItemCount > 0, isEditing {
            navigationItem.title = "\(selectedItemCount)개 선택"
        } else {
            navigationItem.title = "이슈"
        }
    }
}

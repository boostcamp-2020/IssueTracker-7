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
    
    // MARK: 컬렉션뷰
    @IBOutlet private var collectionView: UICollectionView!
    private var issueInfoList: [IssueInfo] = []
    private let api = BackEndAPIManager(router: Router())

    // MARK: 필터
    @IBOutlet private var filterButtonItem: UIBarButtonItem!
    private let filterInfo = FilterInfo()
    
    // MARK: 검색
    private var filteredIssueInfoList: [IssueInfo] = []
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        return searchController
    }()
    
    // MARK: 편집
    private lazy var selectAllButtonItem: UIBarButtonItem = UIBarButtonItem(
        title: barButtonItemState.selectAll.rawValue,
        style: .plain,
        target: self,
        action: #selector(pressedSelectAllButton))
    private var selectAllActive: Bool = false {
        didSet {
            if selectAllActive {
                navigationItem.leftBarButtonItem?.title = barButtonItemState.deselectAll.rawValue
                selectAllItems()
            } else {
                navigationItem.leftBarButtonItem?.title = barButtonItemState.selectAll.rawValue
                deselectAllItems()
            }
            setNavigationTitle()
        }
    }
    
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        configureInitialData()
        collectionView.layoutIfNeeded()
        configureLayout()
        configureNavigationBarButtonItem()
    }

    
    // MARK: - Method
    
    func requestFiltering(with filterInfo: FilterInfo) {
        self.api.requestFiltering(conditions: filterInfo) { result in
            switch result {
            case .success(let issueInfoList):
                self.issueInfoList = issueInfoList
                DispatchQueue.main.async {
                    let indexSet = IndexSet(integer: 0)
                    self.collectionView.reloadSections(indexSet)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /**
            - **FilteringController 로 넘기는 정보**
                - 1. FilterInfo 객체
                - 2. 미리 지정된 조건 선택 시 동작할 핸들러
                - 3. 세부 조건들 선택 시 동작할 핸들러
         */
        
        if segue.identifier == "IssueListToFilter" {
            guard let navigationController = segue.destination as? UINavigationController,
                  let viewController = navigationController.topViewController as? FilteringController
            else { return }
            
            viewController.filterInfo = filterInfo
            
            viewController.predefinedConditionHandler = { filterInfo in
                self.requestFiltering(with: filterInfo)
                self.filterInfo.removeAll()
            }
            
            viewController.detailConditionHandler = { filterInfo in
                self.requestFiltering(with: filterInfo)
            }
        }
    }
}


// MARK: - Extension

// MARK: 검색
extension IssueListViewController: UISearchResultsUpdating {
    
    func filterIssueInfoForSearchKeyword(keyword: String) {
        
        filteredIssueInfoList = issueInfoList.filter { issueInfo in
            issueInfo.title.contains(keyword)
        }
        
        collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchKeyword = searchController.searchBar.text else { return }
        filterIssueInfoForSearchKeyword(keyword: searchKeyword)
    }
}

// MARK: 컬렉션뷰 초기 설정
extension IssueListViewController {
    
    private func configureInitialData() {
        api.requestAllIssues() { result in
            switch result {
            case .success(let issues):
                self.issueInfoList = issues

                DispatchQueue.main.async {
                    self.collectionView.reloadSections(IndexSet(integer: 0))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureLayout() {
        let spacing: CGFloat = 10
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = spacing
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }
}

// MARK: 컬렉션뷰 DataSource
extension IssueListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredIssueInfoList.count
        }
        return issueInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueCell.reuseIdentifier, for: indexPath)
                as? IssueCell else { return UICollectionViewCell() }
        cell.delegate = self
        
        if searchController.isActive {
            cell.configure(issueData: filteredIssueInfoList[indexPath.row])
        } else {
            cell.isEditing = isEditing
            cell.configure(issueData: issueInfoList[indexPath.row])
            
            // cell을 reuse하기 전에 cell이 selected items에 포함된다면 selected 표시 -- selected된 cell이 reuse 되면서 selected state가 유지되는 버그를 수정함
            if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.contains(indexPath) {
                cell.isSelected = true
            }
        }
        return cell
    }
}

// MARK: 컬렉션뷰 Delegate
extension IssueListViewController: UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing {
            setNavigationTitle()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing {
            setNavigationTitle()
        }
    }
}

// MARK: 컬렉션뷰 DelegateFlowLayout
extension IssueListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        if issueInfoList[indexPath.item].labels!.count > 0 {
            height += 30
        }
        return CGSize(width: collectionView.frame.width - 30, height: height)
    }
}

// MARK: IssueCellDelegate
extension IssueListViewController: IssueCellDelegate {

    func issueListDidInteracted(cell: IssueCell) {
        guard let visibleCells = collectionView.visibleCells as? [IssueCell] else { return }
        visibleCells.forEach { visibleCell in
            if visibleCell.isSwiped() && visibleCell != cell {
                visibleCell.resetOffset()
            }
        }
    }
    
    func issueListDidTapped(cell: IssueCell) {
        guard let visibleCells = collectionView.visibleCells as? [IssueCell] else { return }
        for visibleCell in visibleCells {
            if visibleCell.isSwiped() { return }
        }
        
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let issueInfo = issueInfoList[indexPath.item]
                
        let storyboard = UIStoryboard(name: StoryboardID.DetailIssueList, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: StoryboardID.DetailIssueListController, creator: { coder in
            return DetailIssueListController(coder: coder, issueInfo: issueInfo)
        })

        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func batchUpdateCells(of indexPaths: [IndexPath]) {
        self.collectionView.performBatchUpdates {
            UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
                self.collectionView.reloadItems(at: indexPaths)
            }.startAnimation()
        }
    }
    
    func issueStatusChanged(cell: IssueCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let issueInfo = issueInfoList[indexPath.item]
        let status: Status = issueInfo.status == "open" ? .closed : .open
        api.requestStatusChange(issueInfo: issueInfo, status: status) { result in
            switch result {
            case .success:
                self.issueInfoList[indexPath.item].status = status.rawValue
                DispatchQueue.main.async {
                    self.batchUpdateCells(of: [indexPath])
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

// MARK: 스크롤뷰 Delegate
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

// MARK: Select/Deselect
extension IssueListViewController {
    
    private func configureNavigationBarButtonItem() {
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem?.title = barButtonItemState.edit.rawValue
    }
    
    private func selectAllItems() {
        guard let collectionView = collectionView else { return }
        (0..<collectionView.numberOfItems(inSection: 0)).forEach { itemIndex in
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
    
    private func changeInfoStatus(of indexPaths: [IndexPath], to status: Status) {
        indexPaths.forEach { indexPath in
            self.issueInfoList[indexPath.item].status = status.rawValue
        }
    }
    
    private func changeStatus(selectedItems: [IndexPath], to status: Status) {
        let group = DispatchGroup()
        var indexPaths: [IndexPath] = []
        
        selectedItems.forEach { indexPath in
            group.enter()
            api.requestStatusChange(issueInfo: issueInfoList[indexPath.item], status: status) { result in
                switch result {
                case .success:
                    indexPaths.append(indexPath)
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.changeInfoStatus(of: indexPaths, to: status)
           
            self.batchUpdateCells(of: indexPaths)
            self.selectAllActive = false
        }
    }
    
    @IBAction func pressedOpenSelectedItems(_ sender: Any) {
        guard let selectedItems = collectionView.indexPathsForSelectedItems else { return }
        
        changeStatus(selectedItems: selectedItems, to: .open)
    }
    
    @IBAction func pressedCloseSelectedItems(_ sender: UIBarButtonItem) {
        guard let selectedItems = collectionView.indexPathsForSelectedItems else { return }
        
        changeStatus(selectedItems: selectedItems, to: .closed)
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

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
        
        collectionView.layoutIfNeeded()
        configureLayout()
        
    }
    
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
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: collectionView.bounds.size.width, height: 100)
        collectionViewFlowLayout.minimumLineSpacing = 2
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = collectionViewFlowLayout
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "searchBarHeader",
                for: indexPath)
        
        return headerView
    }
}

extension IssueListViewController: UICollectionViewDelegate {
    
extension IssueListViewController: UICollectionViewDelegate { }

extension IssueListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("입력")
    }
}

final class IssueCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: IssueCell.self)
    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!
    @IBOutlet var milestone: UIButton!
    
    @IBOutlet weak var labelStackView: UIStackView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    override func prepareForReuse() {
        labelStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func configure(issueData: IssueData) {
        title.text = issueData.title
        // cell.content.text = // TODO: API 쪽에서 아직 구현이 안되서 추후 수정
        milestone.setTitle(issueData.milestone.title, for: .normal)
        
        issueData.labels?.forEach {
            let btn = UIButton()
            btn.setTitle(" \($0.name) ", for: .normal)
            btn.backgroundColor = hexStringToUIColor(hex: $0.color)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 15)
            btn.cornerRadius = 5
            
            labelStackView.addArrangedSubview(btn)
        }

    }
    
}

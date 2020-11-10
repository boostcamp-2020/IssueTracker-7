//
//  DetailConditionController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/01.
//

import UIKit

final class MileStoneConditionTableViewController: UIViewController {

    // MARK: - Property
    
    @IBOutlet weak var tableView: UITableView!
    private let route: BackEndAPI
    private let filterInfo: FilterInfo
    private let api = BackEndAPIManager(router: Router())
    private var milestoneInfoList: [Milestone] = []
    private var selectedIndex: Int?
    
    
    // MARK: - Initializer
    
    init?(coder: NSCoder, route: BackEndAPI, filterInfo: FilterInfo) {
        self.route = route
        self.filterInfo = filterInfo
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        configureFilterInfo()
    }
    
    
    // MARK: - Method
    
    /**
    - **func configureFilterInfo()**
     - 1. 아무것도 선택하지 않은 경우 selectedIndex 는 nil 이 된다.
     - 2. selectedIndex 가 nil 인 경우 해당 filter 정보(milestone) 는 ""(공백)이 된다.
     */
    func configureFilterInfo() {
        if let selectedIndex = selectedIndex {
            filterInfo.milestone = milestoneInfoList[selectedIndex].title
        } else {
            filterInfo.milestone = ""
        }
    }
    
    func selectIndex() {
        for (index, info) in self.milestoneInfoList.enumerated() {
            if info.title == self.filterInfo.milestone {
                self.selectedIndex = index
                return
            }
        }
    }
    
    func configureInitialData() {
        api.requestDetailCondition(route: route) { (result: Result<[Milestone], APIError>) in
            switch result {
            case .success(let milestoneInfo):
                self.milestoneInfoList = milestoneInfo
                self.selectIndex()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MileStoneConditionTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return milestoneInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MileStoneConditionCell.reuseIdentifier)
                as? MileStoneConditionCell else { return UITableViewCell() }
        
        let milestoneInfo = milestoneInfoList[indexPath.row]
        cell.configure(by: milestoneInfo)
        cell.accessoryType = selectedIndex == indexPath.row ? .checkmark : .none
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 이미 체크된 곳을 누른 경우
        if selectedIndex == indexPath.row {
            selectedIndex = nil
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            selectedIndex = indexPath.row
            
            tableView.visibleCells.forEach { $0.accessoryType = .none }
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
}


final class MileStoneConditionCell: UITableViewCell {
    static let reuseIdentifier = String(describing: MileStoneConditionCell.self)
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        label.layer.cornerRadius = 5
    }
    
    override func prepareForReuse() {
        accessoryType = .none
    }
    
    func configure(by milestoneInfo: Milestone) {
        label.text = " \(milestoneInfo.title) "
    }
}


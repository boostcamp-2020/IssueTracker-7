//
//  DetailConditionController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/01.
//

import UIKit

final class UserConditionTableViewController: UIViewController {

    // MARK: - Property
    
    @IBOutlet weak var tableView: UITableView!
    
    private let route: BackEndAPI
    private let filterInfo: FilterInfo
    private let api = BackEndAPIManager(router: Router())
    private var userInfoList: [Assignee] = []
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
     - 2. selectedIndex 가 nil 인 경우 해당 filter 정보(Author, Assignee) 는 ""(공백)이 된다.
     */
    
    func configureFilterInfo() {
        var userId = ""
        if let selectedIndex = selectedIndex {
            userId = userInfoList[selectedIndex].userID
        }
        
        switch route {
        case .allAuthors:
            filterInfo.author = userId
        case .allAssignees:
            filterInfo.assignee = userId
        default:
            break
        }
    }
    
    func selectIndex(by compared: String) {
        
        selectedIndex = userInfoList.firstIndex {
            $0.userID == compared
        }
    }
    
    func configureInitialData() {
        api.requestDetailCondition(route: route) { (result: Result<[Assignee], APIError>) in
            switch result {
            case .success(let userInfo):
                self.userInfoList = userInfo
                
                switch self.route {
                case .allAuthors:
                    self.selectIndex(by: self.filterInfo.author)
                case .allAssignees:
                    self.selectIndex(by: self.filterInfo.assignee)
                default:
                    break
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UserConditionTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserConditionCell.reuseIdentifier)
                as? UserConditionCell else { return UITableViewCell() }
        
        let userInfo = userInfoList[indexPath.row]
        cell.configure(by: userInfo)
        cell.accessoryType = selectedIndex == indexPath.row ? .checkmark : .none
            
        return cell
    }
}

extension UserConditionTableViewController: UITableViewDelegate {
    
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


class UserConditionCell: UITableViewCell {
    static let reuseIdentifier = String(describing: UserConditionCell.self)
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        label.layer.cornerRadius = 5
    }
    
    override func prepareForReuse() {
        accessoryType = .none
    }
    
    func configure(by userInfo: Assignee) {
        label.text = " \(userInfo.userID) "
    }
}


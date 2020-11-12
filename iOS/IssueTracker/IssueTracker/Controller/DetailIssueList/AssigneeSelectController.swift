//
//  AssigneeSelectController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/12.
//

import UIKit

protocol SendAssigneeDelegate: AnyObject {
    func send(newAssignees: [Assignee])
}

class AssigneeSelectController: UIViewController {

    // MARK: - Property
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let route: BackEndAPI = BackEndAPI.allAssignees
    private let api = BackEndAPIManager(router: Router())
    
    private var unselectedAssignees: Set<Assignee> = []
    var selectedAssignees: [Assignee] = []
    private var sectionsInfo: [[Assignee]] = []
    private let sectionsTitle = ["지정 담당자", "미지정"]
    
    weak var delegate: SendAssigneeDelegate?
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialData()
    }
    
    
    // MARK: - Method
    
    private func configureInitialData() {
        api.requestDetailCondition(route: route) { (result: Result<[Assignee], APIError>) in
            
            switch result {
            case .success(let assigneeInfoList):
                let unselectedAssignees = Set(assigneeInfoList).subtracting(Set(self.selectedAssignees))
                
                // 지정된 담당자는 선택순서, 미지정된 담당자는 알파벳 순서대로
                let sortedUnSelected = unselectedAssignees.sorted { $0.userID < $1.userID }
                
                self.sectionsInfo.append(self.selectedAssignees)
                self.sectionsInfo.append(sortedUnSelected)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction private func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction private func doneButtonTapped(_ sender: Any) {
        delegate?.send(newAssignees: sectionsInfo[0])
        dismiss(animated: true)
    }
}


// MARK: - Extension

// MARK: 테이블뷰 DataSource
extension AssigneeSelectController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsInfo.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionsInfo[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AssigneeCell.reuseIdentifier)
                as? AssigneeCell else { return UITableViewCell() }
        
        cell.configure(by: sectionsInfo[indexPath.section][indexPath.row])
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionsTitle[section]
    }
}

// MARK: 테이블뷰 Delegate
extension AssigneeSelectController: UITableViewDelegate {
    
    func change(index: Int, ofSection section1: Int, toSection section2: Int) {
        let unselected = sectionsInfo[section1].remove(at: index)
        sectionsInfo[section2].append(unselected)
        sectionsInfo[section2].sort { $0.userID < $1.userID }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            change(index: indexPath.row, ofSection: 0, toSection: 1)
        case 1:
            change(index: indexPath.row, ofSection: 1, toSection: 0)
        default:
            break
        }
        tableView.reloadSections(IndexSet(integersIn: 0...1), with: .automatic)
    }
}


class AssigneeCell: UITableViewCell {
    static let reuseIdentifier = String(describing: AssigneeCell.self)
    @IBOutlet weak var userID: UILabel!
    
    func configure(by assigneeInfo: Assignee) {
        userID.text = assigneeInfo.userID
    }
}

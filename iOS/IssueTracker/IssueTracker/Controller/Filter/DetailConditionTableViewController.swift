//
//  DetailConditionController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/01.
//

import UIKit

class DetailConditionTableViewController<InfoType: Decodable>: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private let route: BackEndAPI
    private let detailFilterInfo: FilterInfo
    
    init?(coder: NSCoder, route: BackEndAPI, detailFilterInfo: FilterInfo) {
        self.route = route
        self.detailFilterInfo = detailFilterInfo
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(route, InfoType.self)
        
        // 여기서 API 호출(작성자, 레이블, 마일스톤, 담당자)해서 데이터 객체 갱신
//        BackEndAPIManager.shared.requestDetailCondition(route: route) { (result: Result<InfoType, APIError>) in
//
//        }

        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailConditionCell.reuseIdentifier) else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "샘플"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailFilterInfo.assignees.append(Assignee(id: 3, userID: "dsdf"))
    }
    
    
    
}


class DetailConditionCell: UITableViewCell {
    static let reuseIdentifier = String(describing: DetailConditionCell.self)
    
    
    
}

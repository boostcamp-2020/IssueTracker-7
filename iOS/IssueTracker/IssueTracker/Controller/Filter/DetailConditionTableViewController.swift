//
//  DetailConditionController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/01.
//

import UIKit

class DetailConditionTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 여기서 API 호출(작성자, 레이블, 마일스톤, 담당자)해서 데이터 객체 갱신
    }
}

extension DetailConditionTableViewController: UITableViewDataSource {
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
    
    
}

extension DetailConditionTableViewController: UITableViewDelegate {
    
}

class DetailConditionCell: UITableViewCell {
    static let reuseIdentifier = String(describing: DetailConditionCell.self)
    
    
    
}

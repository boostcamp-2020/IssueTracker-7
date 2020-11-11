//
//  DetailConditionController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/01.
//

import UIKit

/**
 - **func LabelConditionTableViewController()**
    - 1. User / MileStoneConditionTableViewController 와 다르게 여러 조건 선택이 가능하다.
    - 2. 때문에 데이터 Model 내부에 isSelected 를 두어서 일괄적으로 처리한다.
 */

final class LabelConditionTableViewController: UIViewController {

    // MARK: - Property
    
    @IBOutlet weak var tableView: UITableView!
    
    private let route: BackEndAPI
    private let filterInfo: FilterInfo
    private let api = BackEndAPIManager(router: Router())
    private var labelInfoList: [LabelInfo] = []
    
    
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
        - 1. 데이터 모델을 순회하여 isSelected 가 true 인 배열 제작
        - 2. 해당 배열 중에서 name(String) 데이터만 뽑아서 배열 제작하고 filterInfo 에 대입
     */
    func configureFilterInfo() {
        filterInfo.label = labelInfoList.filter {
            $0.isSelected ?? false
        }.map {
            $0.name
        }
    }
    
    /**
     - **func activateIsSelected()**
        - filterInfo 의 label 과 일치하는 labelInfo 데이터들의 isSelected 를 활성화(true) 해주는 역할
     */
    func activateIsSelected() {
        
        labelInfoList.indices.forEach {
            if filterInfo.label.contains(labelInfoList[$0].name) {
                labelInfoList[$0].isSelected = true
            }
        }
    }
    
    func configureInitialData() {
        api.requestDetailCondition(route: route) { (result: Result<[LabelInfo], APIError>) in
            switch result {
            case .success(let labelInfo):
                self.labelInfoList = labelInfo
                self.activateIsSelected()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LabelConditionTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelConditionCell.reuseIdentifier)
                as? LabelConditionCell else { return UITableViewCell() }
        let labelInfo = labelInfoList[indexPath.row]
        cell.configure(by: labelInfo)
        cell.accessoryType = (labelInfo.isSelected ?? false) ? .checkmark : .none
        
        return cell
    }
}

extension LabelConditionTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? LabelConditionCell else { return }
        
        labelInfoList[indexPath.row].isSelected = !(labelInfoList[indexPath.row].isSelected ?? false)
        cell.accessoryType = (labelInfoList[indexPath.row].isSelected ?? false) ? .checkmark : .none
    }
}


class LabelConditionCell: UITableViewCell {
    static let reuseIdentifier = String(describing: LabelConditionCell.self)
    @IBOutlet weak var label: UIButton!
    
    override func awakeFromNib() {
        label.layer.cornerRadius = 5
    }
    
    func configure(by labelInfo: LabelInfo) {
        label.setTitle(" \(labelInfo.name) ", for: .normal)
        label.backgroundColor = labelInfo.color.hexStringToUIColor()
    }
}

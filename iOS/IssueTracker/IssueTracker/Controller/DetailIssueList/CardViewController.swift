//
//  CardViewController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/12.
//

import UIKit

class CardViewController: UIViewController {
    
    // MARK: - Property
    
    private let api = BackEndAPIManager(router: Router())
    
    @IBOutlet weak var handle: UIView!
    @IBOutlet weak var commentAddBtn: UIButton!
    @IBOutlet weak var commentUpDownStackView: UIStackView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var assigneeStackView: AssigneesProfileStackView!
    
    var issueInfo: IssueInfo?
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        if let assignees = issueInfo?.assignees {
            reloadAssigneeProfiles(assignees: assignees)
        }
    }
    
    func setUpViews() {
        handle.layer.cornerRadius = 5
        
        commentAddBtn.setUpShadow()
        commentAddBtn.layer.cornerRadius = 5
        
        baseView.backgroundColor = UIColor.clear
        baseView.setUpShadow()
        
        commentUpDownStackView.layer.masksToBounds = true
        commentUpDownStackView.layer.cornerRadius = 5
        
        closeButton.setUpShadow()
        closeButton.layer.cornerRadius = 5
    }
}


// MARK: - Extension

// MARK: 담당자(Assignee)
extension CardViewController {
    func reloadAssigneeProfiles(assignees: [Assignee]) {
        
        let group = DispatchGroup()
        
        var assignees = assignees
        assignees.enumerated().forEach { (index, assignee) in
            if let url = assignee.photoURL {
                group.enter()
                api.requestPhoto(path: url) { result in
                    switch result {
                    case .success(let imageData):
                        assignees[index].data = imageData
                    case .failure(let error):
                        print(error)
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.assigneeStackView.configure(by: assignees)
        }
    }
    
    
    @IBAction func editAssignees(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "DetailIssueList", bundle: nil)
        
        guard let navigationController = storyboard.instantiateViewController(
                identifier: "AssigneeNavigationController") as? UINavigationController,
              let viewController = navigationController.topViewController as? AssigneeSelectController
        else { return }
        
        viewController.delegate = self
        if let assignees = issueInfo?.assignees {
            viewController.selectedAssignees = assignees
        }
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true)
    }
}

extension CardViewController: SendAssigneeDelegate {
    
    func updateBackEnd(of issueNumber: Int, by originAssignees: Set<Assignee>, and newAssignees: Set<Assignee>) {
        
        // 원본 - 새 담당자 = 빼야 할 담당자들
        let deletedAssignees = originAssignees.subtracting(newAssignees)
        deletedAssignees.forEach { assignee in
            api.requestDeleteAssignee(issueNumber: "\(issueNumber)", userID: assignee.id) { result in
                switch result {
                case .success(let assignee):
                    print(assignee)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        let addedAssignees = Set(newAssignees).subtracting(Set(originAssignees))
        addedAssignees.forEach { assignee in
            api.requestAddAssignee(issueNumber: "\(issueNumber)", userID: assignee.id) { result in
                switch result {
                case .success(let assignee):
                    print(assignee)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func send(newAssignees: [Assignee]) {
        
        guard let originAssignees = issueInfo?.assignees, let issueNumber = issueInfo?.id else { return }
        
        updateBackEnd(of: issueNumber, by: Set(originAssignees), and: Set(newAssignees))
        
        self.assigneeStackView.initializeView()
        self.reloadAssigneeProfiles(assignees: newAssignees)
        self.issueInfo?.assignees = newAssignees
    }
}


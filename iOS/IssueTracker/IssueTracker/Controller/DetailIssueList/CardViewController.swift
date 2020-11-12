//
//  CardViewController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/12.
//

import UIKit

protocol CardViewControllerDelegate {

    func changeIssueStatus (to: Status)
    func animateCardView (to state: DetailIssueListController.CardState, withDuration duration: TimeInterval, bounce: CGFloat)
}

class CardViewController: UIViewController {
    
    // MARK: - Property
    
    private let api = BackEndAPIManager(router: Router())
    
    @IBOutlet private weak var handle: UIView!
    @IBOutlet private weak var commentAddBtn: UIButton!
    @IBOutlet private weak var closeButton: UIButton!
    
    @IBOutlet weak var assigneeStackView: AssigneesProfileStackView!
        
    var delegate: CardViewControllerDelegate?
    var commentViewControllerDelegate: CommentViewControllerDelegate?
    var issueInfo: IssueInfo!
    
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
        
        closeButton.setUpShadow()
        closeButton.layer.cornerRadius = 5
        closeButton.setTitle(issueInfo.status == "closed" ? "이슈 열기" : "이슈 닫기", for: .normal)
        
    }




    @IBAction func pressedAddCommentButton(_ sender: UIButton) {
        
//        guard let issueInfo = issueInfo else { return }
        let storyboard = UIStoryboard(name: "CommentView", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "CommentViewController") as! CommentViewController
        viewController.issueId = issueInfo.id
        viewController.delegate = commentViewControllerDelegate
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func pressedCloseButton(_ sender: UIButton) {
        
        let targetIssueStatus: Status = issueInfo.status == "closed" ? .open : .closed
        
        api.requestStatusChange(issueInfo: issueInfo, status: targetIssueStatus) {
            result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.delegate?.changeIssueStatus(to: targetIssueStatus)
                        self.delegate?.animateCardView(to: .collapsed, withDuration: 0.1, bounce: 0)
                        self.closeButton.setTitle(self.issueInfo.status == "closed" ? "이슈 열기" : "이슈 닫기", for: .normal)
                        self.closeButton.setTitleColor(self.issueInfo.status == "closed" ? UIColor.systemGreen : UIColor.systemRed, for: .normal)
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}

// MARK: 담당자(Assignee)
extension CardViewController {
    private func reloadAssigneeProfiles(assignees: [Assignee]) {
        
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
    
    
    @IBAction private func editAssignees(_ sender: Any) {
        
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
    
    private func updateBackEnd(of issueNumber: Int, by originAssignees: Set<Assignee>, and newAssignees: Set<Assignee>) {
        
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


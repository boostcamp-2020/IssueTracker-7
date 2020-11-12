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

    @IBOutlet weak var handle: UIView!
    @IBOutlet weak var commentAddBtn: UIButton!
    @IBOutlet weak var commentUpDownStackView: UIStackView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    private let api = BackEndAPIManager(router: Router())
    
    var delegate: CardViewControllerDelegate?
    var commentViewControllerDelegate: CommentViewControllerDelegate?
    var issueInfo: IssueInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
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



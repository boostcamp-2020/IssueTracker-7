//
//  CommentView.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/12.
//

import UIKit

protocol CommentViewControllerDelegate: AnyObject {
    
    func appendComment(comment: Comment)
}

final class CommentViewController: UIViewController {
    
    private let api = BackEndAPIManager(router: Router())
    weak var delegate: CommentViewControllerDelegate?
    var issueId: Int? = nil
    
    @IBOutlet var commentTextview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureTextview()
    }
    
    private func configureTextview () {
        commentTextview.delegate = self
    }
    
    @IBAction func pressedCancel(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedSave(_ sender: UIButton) {
        
        guard let issueId = issueId else { return }
        
        api.addComment(issueId: issueId, content: commentTextview.text )  { result in
            switch result {
            case .success(let comment):
                DispatchQueue.main.async {
                    self.delegate?.appendComment(comment: comment)
                    // TODO: comment를 상세화면으로 전달하여 추가해주기 delegate 이용?
                }
            case .failure(let error):
                print(error)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func addComment() {
        
        
    }
}

extension CommentViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentTextview.textColor == .lightGray && commentTextview.isFirstResponder {
            commentTextview.text = nil
            commentTextview.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextview.text.isEmpty || commentTextview.text == "" {
            commentTextview.textColor = .lightGray
            commentTextview.text = "이곳에 댓글을 작성해주세요."
        }
    }
}

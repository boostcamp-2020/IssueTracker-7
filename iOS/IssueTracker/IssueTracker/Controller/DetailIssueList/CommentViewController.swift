//
//  CommentView.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/12.
//

import UIKit

final class CommentViewController: UIViewController {
    
    @IBOutlet var commentTextview: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func commonInitializer() {
        configureTextview()
    }
    
    private func configureTextview () {
        commentTextview.delegate = self
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

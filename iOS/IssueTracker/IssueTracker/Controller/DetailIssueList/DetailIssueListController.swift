//
//  DetailIssueListController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/03.
//

import UIKit

class DetailIssueListController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        DetailIssueListController
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "ReactionViewController") as! ReactionViewController
        
        vc.modalPresentationStyle = .fullScreen
        
        // 딜레이를 넣어야 누른 버튼이 희미해지는 현상 해결 가능
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // tabbar.view 로 해야 탭바까지 스냅샷
            vc.backingImage = self.view.asImage()
            
            self.present(vc, animated: false) // false 로 해야 default 애니메이션을 안 쓸 수 있음
        }
    }
    
}

extension UIView  {
    // render the view within the view's bounds, then capture it as image
  func asImage() -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: bounds)
    return renderer.image(actions: { rendererContext in
        layer.render(in: rendererContext.cgContext)
    })
  }
}

//
//  DetailIssueListController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/03.
//

import UIKit

class DetailIssueListController: UIViewController {
    
    enum CardState {
        case collapsed
        case expanded
    }
    
    @IBOutlet weak var dimmerView: UIView!
    
    lazy var cardStartY: CGFloat = view.bounds.height * 0.1
    lazy var cardEndY: CGFloat = view.bounds.height * 0.85
    
    lazy var cardLatestY : CGFloat = cardEndY // 제스쳐 start 시 갱신되는 가장 최신의 Y 좌표
    var cardCurrentState: CardState = .collapsed
    
    var cardViewController:CardViewController!
    var visualEffectView:UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dimmerView.isUserInteractionEnabled = false
        dimmerView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        visualEffectView.removeFromSuperview()
        cardViewController.view.removeFromSuperview()
    }
    
    func setupCard() {
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = tabBarController!.view.bounds
        visualEffectView.isUserInteractionEnabled = false
        tabBarController?.view.addSubview(visualEffectView)
        
        cardViewController = CardViewController(nibName: "CardViewController", bundle: nil)
        tabBarController?.view.addSubview(cardViewController.view)
        self.cardViewController.view.frame = CGRect(x: 0, y: view.bounds.height, width: self.view.bounds.width, height: self.view.frame.height - cardStartY)

        UIViewPropertyAnimator(duration: 0.1, curve: .easeIn) {
            self.cardViewController.view.frame.origin.y = self.cardEndY
        }.startAnimation()
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 15.0
        cardViewController.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        cardViewController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {

        switch recognizer.state {
        case .began:
            cardLatestY = cardViewController.view.frame.origin.y
        case .changed:
            let translation = recognizer.translation(in: cardViewController.view)
            let expectedY = cardLatestY + translation.y
            
            if (cardStartY...cardEndY) ~= expectedY {
                cardViewController.view.frame.origin.y = cardLatestY + translation.y
            }
        case .ended:
            switch cardCurrentState {
            case .collapsed:
                if cardViewController.view.frame.origin.y < cardLatestY {
                    animateTransitionIfNeeded(state: .expanded, duration: 0.1) // 확장
                }
            case .expanded:
                if cardViewController.view.frame.origin.y > cardLatestY {
                    animateTransitionIfNeeded(state: .collapsed, duration: 0.1) // 최소화
                }
            }
        default:
            break
        }
    }
    
    // Animate transistion function
    func animateTransitionIfNeeded (state: CardState, duration: TimeInterval) {
        
        // TODO: 추후 UIViewPropertyAnimator fractionComplete 활용해서 더 interactive 하게 만들어보기
        let frameAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            switch state {
            case .expanded:
                self.cardViewController.view.frame.origin.y = self.cardStartY
                self.dimmerView.alpha = 0.7
                self.visualEffectView.effect = UIBlurEffect(style: .dark)
                self.visualEffectView.alpha = 0.65
                
                self.cardCurrentState = .expanded
            case .collapsed:
                self.cardViewController.view.frame.origin.y = self.cardEndY
                self.dimmerView.alpha = 0
                self.visualEffectView.effect = nil
                self.visualEffectView.alpha = 1
                
                self.cardCurrentState = .collapsed
            }
        }
        
        cardLatestY = cardViewController.view.frame.origin.y
    
        frameAnimator.startAnimation()
    }
}


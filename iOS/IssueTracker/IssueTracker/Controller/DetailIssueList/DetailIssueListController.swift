//
//  DetailIssueListController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/03.
//

import UIKit

final class DetailIssueListController: UIViewController {
    
    // MARK: - Enum
    
    enum CardState {
        case collapsed
        case expanded
    }
    
    
    // MARK: - Property
    
    var cardView: CardView!
    lazy var dimmerView: UIView = {
        let dimmerView = UIView()
        dimmerView.backgroundColor = UIColor.gray
        dimmerView.frame = self.view.bounds
        return dimmerView
    }()
    
    lazy var cardStartY: CGFloat = view.bounds.height * 0.1
    lazy var cardEndY: CGFloat = view.bounds.height * 0.85
    
    lazy var cardLatestY : CGFloat = cardEndY // 제스쳐 start 시 갱신되는 가장 최신의 Y 좌표
    var cardCurrentState: CardState = .collapsed
    
    
    // MARK: - Life Cycle
    
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
        
        dimmerView.removeFromSuperview()
        cardView.removeFromSuperview()
    }
    
    
    // MARK: - Method
    
    func setupCard() {
        tabBarController?.view.addSubview(dimmerView)
        
        cardView = CardView()
        tabBarController?.view.addSubview(cardView)

        cardView.frame = CGRect(
            x: 0,
            y: view.bounds.height,
            width: self.view.bounds.width,
            height: self.view.frame.height - cardStartY
        )
        
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
            self.cardView.frame.origin.y = self.cardEndY
        }.startAnimation()

        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 15.0
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        cardView.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dimmerViewTapped))
        dimmerView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    func dimmerViewTapped() {
        animateTransitionIfNeeded(state: .collapsed, duration: 0.1) // 최소화
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {

        switch recognizer.state {
        case .began:
            cardLatestY = cardView.frame.origin.y
        case .changed:
            let translation = recognizer.translation(in: cardView)
            let expectedY = cardLatestY + translation.y
            
            if (cardStartY...cardEndY) ~= expectedY {
                cardView.frame.origin.y = cardLatestY + translation.y
            }
        case .ended:
            switch cardCurrentState {
            case .collapsed:
                if cardView.frame.origin.y < cardLatestY {
                    animateTransitionIfNeeded(state: .expanded, duration: 0.1) // 확장
                }
            case .expanded:
                if cardView.frame.origin.y > cardLatestY {
                    animateTransitionIfNeeded(state: .collapsed, duration: 0.1) // 최소화
                }
            }
        default:
            break
        }
    }
    
    func animateTransitionIfNeeded (state: CardState, duration: TimeInterval) {
        
        // TODO: 추후 UIViewPropertyAnimator fractionComplete 활용해서 더 interactive 하게 만들어보기
        let frameAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            switch state {
            case .expanded:
                self.cardView.frame.origin.y = self.cardStartY
                self.dimmerView.alpha = 0.7
                self.dimmerView.isUserInteractionEnabled = true
                
                self.cardCurrentState = .expanded
            case .collapsed:
                self.cardView.frame.origin.y = self.cardEndY
                self.dimmerView.alpha = 0
                self.dimmerView.isUserInteractionEnabled = false
        
                self.cardCurrentState = .collapsed
            }
        }
        
        cardLatestY = cardView.frame.origin.y
    
        frameAnimator.startAnimation()
    }
    
}


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
    
    enum Section {
        case main
    }
    
    
    // MARK: - Property
    
    var cardView: CardView = CardView()
    var baseView = UIView()
    
    lazy var dimmerView: UIView = {
        let dimmerView = UIView()
        dimmerView.backgroundColor = UIColor.gray
        dimmerView.frame = self.view.bounds
        return dimmerView
    }()
    
    lazy var cardMinimumY: CGFloat = view.bounds.height * 0.1
    lazy var cardMaximumY: CGFloat = view.bounds.height * 0.85
    
    lazy var cardLatestY: CGFloat = cardMaximumY // 제스쳐 start 시 갱신되는 가장 최신의 Y 좌표
    var cardCurrentState: CardState = .collapsed
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, DetailIssueInfo>!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDimmerView()
        
        configureCollectionView()
        configureDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCardView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dimmerView.removeFromSuperview()
        baseView.removeFromSuperview()
    }
    
    
    // MARK: - Method
    
    func setUpDimmerView() {
        dimmerView.isUserInteractionEnabled = false
        dimmerView.alpha = 0
    }
    
    func addGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        baseView.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dimmerViewTapped))
        dimmerView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupCardView() {
        
        tabBarController?.view.addSubview(dimmerView)
        tabBarController?.view.addSubview(baseView)
        
        // baseView 의 시작지점 및 시작 애니메이션 설정
        baseView.frame = CGRect(
            x: 0,
            y: view.bounds.height,
            width: self.view.bounds.width,
            height: self.view.frame.height - cardMinimumY
        )
        
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
            self.baseView.frame.origin.y = self.cardMaximumY
        }.startAnimation()
        
        
        // baseView 및 cardView 의 테두리, 그림자 설정
        baseView.addSubview(cardView)
        cardView.frame = baseView.bounds
        
        baseView.setUpShadow(radius: 4, opacity: 0.35)
        baseView.backgroundColor = .clear
        
        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 15.0
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Pan 제스쳐 설정
        addGesture()
    }
    
    @objc func dimmerViewTapped() {
        animateCardView(to: .collapsed, duration: 0.1) // 최소화
    }
        
    @objc func handleCardPan (recognizer:UIPanGestureRecognizer) {

        dimmerView.alpha = (1 - (baseView.frame.origin.y - cardMinimumY) / (cardMaximumY - cardMinimumY)) * 0.7
        
        switch recognizer.state {
        case .began:
            cardLatestY = baseView.frame.origin.y
        case .changed:
            let translation = recognizer.translation(in: baseView)
            let expectedY = cardLatestY + translation.y
            
            if (cardMinimumY...cardMaximumY) ~= expectedY {
                baseView.frame.origin.y = cardLatestY + translation.y
            }
        case .ended:
            let velocity = recognizer.velocity(in: baseView)
            if velocity.y > 1000 {
                animateCardView(to: .collapsed, duration: 0.15)
                return
            } else if velocity.y < -1000 {
                animateCardView(to: .expanded, duration: 0.15)
                return
            }
    
            let cardMidY = cardMinimumY + (cardMaximumY - cardMinimumY) / 2
            
            if (cardMinimumY...cardMidY) ~= baseView.frame.origin.y {
                animateCardView(to: .expanded, duration: 0.15)
            } else {
                animateCardView(to: .collapsed, duration: 0.15)
            }
        default:
            break
        }
    }
    
    func animateCardView (to state: CardState, duration: TimeInterval) {
        
        let frameAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            switch state {
            case .expanded:
                self.baseView.frame.origin.y = self.cardMinimumY
                self.dimmerView.isUserInteractionEnabled = true
                self.dimmerView.alpha = 0.7
                
                self.cardCurrentState = .expanded
            case .collapsed:
                self.baseView.frame.origin.y = self.cardMaximumY
                self.dimmerView.isUserInteractionEnabled = false
                self.dimmerView.alpha = 0
        
                self.cardCurrentState = .collapsed
            }
        }
        
        cardLatestY = baseView.frame.origin.y
    
        frameAnimator.startAnimation()
    }
}

// MARK: collectionView

extension DetailIssueListController {
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureCollectionView() {
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, DetailIssueInfo>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch indexPath.row {
            case 0:
                // TODO: 이 부분은 추후에 HeaderView 로 수정필요
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailIssueTopCell.reuseIdentifier, for: indexPath) as? DetailIssueTopCell else {
                    fatalError("Cannot create new cell")
                }
                DetailIssueTopCell.configureCell(cell: cell, data: item)
                return cell
            default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailIssueCell.reuseIdentifier, for: indexPath) as? DetailIssueCell else {
                    fatalError("Cannot create new cell")
                }
                DetailIssueCell.configureCell(cell: cell, data: item)
                return cell
            }
        }
        
        let dummy = [DetailIssueInfo(id: 1, content: "샘플", updateAt: "샘플", user: User(id: 1, userId: "샘플")),
                     DetailIssueInfo(id: 2, content: "샘플", updateAt: "샘플", user: User(id: 1, userId: "샘플")),
                     DetailIssueInfo(id: 3, content: "샘플", updateAt: "샘플", user: User(id: 1, userId: "샘플")),
                     DetailIssueInfo(id: 4, content: "샘플", updateAt: "샘플", user: User(id: 1, userId: "샘플")),
                     DetailIssueInfo(id: 5, content: "샘플", updateAt: "샘플", user: User(id: 1, userId: "샘플")),
                     DetailIssueInfo(id: 6, content: "샘플", updateAt: "샘플", user: User(id: 1, userId: "샘플"))]
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, DetailIssueInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(dummy)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

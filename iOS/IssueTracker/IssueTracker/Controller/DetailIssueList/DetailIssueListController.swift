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
    
    private let headerInfo: HeaderDetailIssueInfo!
    
    private let cardView: CardView = CardView()
    private let baseView = UIView()
    private let bounce: CGFloat = 10
    private let maximumAlpha: CGFloat = 0.7
    
    private lazy var dimmerView: UIView = {
        let dimmerView = UIView()
        dimmerView.backgroundColor = UIColor.gray
        dimmerView.frame = self.view.bounds
        return dimmerView
    }()
    
    private lazy var cardMinimumY: CGFloat = view.bounds.height * 0.1
    private lazy var cardMaximumY: CGFloat = view.bounds.height * 0.85
    
    private lazy var cardLatestY: CGFloat = cardMaximumY // 제스쳐 start 시 갱신되는 가장 최신의 Y 좌표
    private var cardCurrentState: CardState = .collapsed
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, DetailIssueInfo>!
    
    
    init?(coder: NSCoder, headerinfo: HeaderDetailIssueInfo) {
        self.headerInfo = headerinfo
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        configureDataSource()
        setUpDimmerView()
        configureCollectionView()
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
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(baseViewPanned))
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
            height: self.view.frame.height - cardMinimumY + bounce
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
        animateCardView(to: .collapsed, withDuration: 0.1) // 최소화
    }
        
    @objc func baseViewPanned (recognizer:UIPanGestureRecognizer) {

        dimmerView.alpha = (1 - (baseView.frame.origin.y - cardMinimumY) / (cardMaximumY - cardMinimumY)) * maximumAlpha
        
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
            // velocity 기준 자동 확대 / 축소
            let velocity = recognizer.velocity(in: baseView)
            if velocity.y > 1000 {
                animateCardView(to: .collapsed, withDuration: 0.2, bounce: bounce)
                return
            } else if velocity.y < -1000 {
                animateCardView(to: .expanded, withDuration: 0.2, bounce: bounce)
                return
            }
    
            // CardView Y 좌표 기준 자동 확대 / 축소
            let cardMidY = cardMinimumY + (cardMaximumY - cardMinimumY) / 2
            
            if (cardMinimumY...cardMidY) ~= baseView.frame.origin.y {
                animateCardView(to: .expanded, withDuration: 0.2)
            } else {
                animateCardView(to: .collapsed, withDuration: 0.2)
            }
        default:
            break
        }
    }
    
    func animateCardView (to state: CardState, withDuration duration: TimeInterval, bounce: CGFloat = 0) {
        
        let frameAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            switch state {
            case .expanded:
                self.baseView.frame.origin.y = self.cardMinimumY - bounce
                self.dimmerView.isUserInteractionEnabled = true
                self.dimmerView.alpha = self.maximumAlpha
                
                self.cardCurrentState = .expanded
            case .collapsed:
                self.baseView.frame.origin.y = self.cardMaximumY + bounce
                self.dimmerView.isUserInteractionEnabled = false
                self.dimmerView.alpha = 0
        
                self.cardCurrentState = .collapsed
            }
        }
        
        if bounce != 0 {
            frameAnimator.addCompletion { _ in
                switch state {
                case .expanded:
                    UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
                        self.baseView.frame.origin.y = self.cardMinimumY
                    }.startAnimation()
                case .collapsed:
                    UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
                        self.baseView.frame.origin.y = self.cardMaximumY
                    }.startAnimation()
                }
            }
        }
        
        cardLatestY = baseView.frame.origin.y
        frameAnimator.startAnimation()
    }
}

// MARK: collectionView

extension DetailIssueListController: UICollectionViewDelegate {
    
    private func createLayout() -> UICollectionViewLayout {
//        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
//        collectionView.register(
//                    DetailIssueHeader.self,
//                    forSupplementaryViewOfKind: "section-header-element-kind",
//                    withReuseIdentifier: DetailIssueHeader.reuseIdentifier) 
        let heightDimension = NSCollectionLayoutDimension.estimated(500)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: heightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: "DetailIssueHeader",
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureCollectionView() {
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, DetailIssueInfo>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailIssueCell.reuseIdentifier, for: indexPath) as? DetailIssueCell else {
                fatalError("Cannot create new cell")
            }
            DetailIssueCell.configureCell(cell: cell, data: item)
            return cell
            
        }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailIssueHeader.reuseIdentifier, for: indexPath) as? DetailIssueHeader else { return nil }
            DetailIssueHeader.configureCell(cell: supplementaryView, data: self.headerInfo)
            
            return supplementaryView
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

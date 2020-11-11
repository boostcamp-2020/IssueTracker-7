//
//  IssueCell.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/05.
//

import UIKit

protocol IssueCellDelegate: AnyObject {
    func issueListDidInteracted(cell: IssueCell)
    func issueListDidTapped(cell: IssueCell)
    
    func issueStatusChanged(cell: IssueCell)
}

final class IssueCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let reuseIdentifier = String(describing: IssueCell.self)
    weak var delegate: IssueCellDelegate?
    private lazy var contentOffset: CGFloat = ceil(bounds.width * 0.1 * 10) / 10
    
    var isEditing: Bool = false {
        didSet {
            if !isEditing {

                scrollView.isUserInteractionEnabled = true
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                        self.scrollView.contentOffset.x = self.contentOffset
                    }, completion: nil)
                }
                hideSelectLabel()
            } else {

                scrollView.isUserInteractionEnabled = false
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                        self.scrollView.contentOffset.x = -self.contentOffset
                    }, completion: nil)
                }
                showSelectLabel()
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                selectLabel.text = isSelected ? "✓" : ""
                selectLabel.backgroundColor = isSelected ? .systemBlue : .white
                selectLabel.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.gray.cgColor
                visibleView.subviews.first?.backgroundColor = isSelected ? .systemGray5 : .white
                selectView.backgroundColor = isSelected ? .systemGray5 : .white
            }
        }
    }
    
    private lazy var selectLabel: UILabel = {
       let selectLabel = UILabel()
        NSLayoutConstraint.activate([
            selectLabel.widthAnchor.constraint(equalToConstant: 20),
            selectLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        selectLabel.layer.cornerRadius = 10
        selectLabel.layer.masksToBounds = true
        selectLabel.layer.borderColor = UIColor.gray.cgColor
        selectLabel.layer.borderWidth = 1.0
        selectLabel.textAlignment = .center
        selectLabel.textColor = .white
        selectLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        selectLabel.isHidden = true
        return selectLabel
    }()
    
    // For swipe
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.layer.cornerRadius = 10
        
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var statusButtonImageView: UIImageView = {
        let statusButtonImageView = UIImageView()
        statusButtonImageView.tintColor = .white
        
        self.statusChangeView.addSubview(statusButtonImageView)
        
        statusButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        statusButtonImageView.centerXAnchor.constraint(equalTo: self.statusChangeView.centerXAnchor).isActive = true
        statusButtonImageView.centerYAnchor.constraint(equalTo: self.statusChangeView.centerYAnchor).isActive = true
        statusButtonImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        statusButtonImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return statusButtonImageView
    }()
    
    private let visibleView = IssueCellContentView()

    private var statusChangeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemRed
        return view
    }()
    
    private var selectView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        scrollView.delegate = self
        setUpView()
        setUpSwipable()
        setUpTapGesture()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        scrollView.delegate = self
        setUpView()
        setUpSwipable()
        setUpTapGesture()
    }

    // MARK: - Method
    
    override func prepareForReuse() {

        visibleView.initLabels()
        isSelected = false
    }
    
    private func setUpTapGesture() {
        
        let visibleRecognizer = UITapGestureRecognizer(target: self, action: #selector(contentTapped))
        visibleView.addGestureRecognizer(visibleRecognizer)
        
        let statusRecognizer = UITapGestureRecognizer(target: self, action: #selector(statusChanged))
        statusChangeView.addGestureRecognizer(statusRecognizer)
    }
    
    @objc private func contentTapped() {
      
        delegate?.issueListDidTapped(cell: self)
        delegate?.issueListDidInteracted(cell: self)
    }
    
    @objc private func statusChanged() {
        
        delegate?.issueStatusChanged(cell: self)
        resetOffset()
    }
    
    private func setUpSwipable() {
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.pinEdgesToSuperView()
        stackView.pinEdgesToSuperView()
                
        stackView.addArrangedSubview(selectView)
        stackView.addArrangedSubview(visibleView)
        stackView.addArrangedSubview(statusChangeView)
        
        selectView.addSubview(selectLabel)

        selectLabel.translatesAutoresizingMaskIntoConstraints = false
        selectView.translatesAutoresizingMaskIntoConstraints = false
        visibleView.translatesAutoresizingMaskIntoConstraints = false
        statusChangeView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            selectView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.1),
            visibleView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            statusChangeView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.2),

            selectLabel.centerXAnchor.constraint(equalTo: selectView.centerXAnchor, constant: 5),
            selectLabel.centerYAnchor.constraint(equalTo: selectView.centerYAnchor)
        ])
    }
   
    
    private func setUpView() {
        
        // cell layer 에는 shadow 를 적용해야 하므로 masktobounds 가 false. 따라서 cell 위에 있는 scrollview 의 cornerradius 를 주면
        // scrollview 위에 있는 visible view 도 같이 코너가 둥글게 나온다.
        layer.cornerRadius = 10
        layer.masksToBounds = false
        setUpShadow(radius: 3, opacity: 0.1)
    }

    func configure(issueData: IssueInfo) {
        if issueData.status == "open" {
            statusChangeView.backgroundColor = .systemRed
            scrollView.backgroundColor = .systemRed
            
            statusButtonImageView.image = UIImage(systemName: "checkmark.circle")
        } else {
            statusChangeView.backgroundColor = .systemGreen
            scrollView.backgroundColor = .systemGreen
            
            statusButtonImageView.image = UIImage(systemName: "exclamationmark.circle")
        }

        visibleView.configure(issueInfo: issueData)
    }
    
    func resetOffset() {
      
        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.scrollView.contentOffset.x = self.contentOffset
        }.startAnimation()
    }
    
    func isSwiped() -> Bool {
        return scrollView.contentOffset.x != self.contentOffset
    }
    
}


// MARK: - Extension

extension IssueCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if !isEditing {
            if scrollView.contentOffset.x < contentOffset + 5 {
                scrollView.contentOffset.x = contentOffset
                scrollView.bounces = false
            } else {
                scrollView.bounces = true
            }
        } else {
            if scrollView.contentOffset.x < 0 {
                scrollView.contentOffset.x = 0
                scrollView.bounces = false
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if !isEditing {
            delegate?.issueListDidInteracted(cell: self)
        }
    }
}

// MARK: - show / hide select label

extension IssueCell {
    
    func showSelectLabel() {
        
        selectLabel.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: { self.selectLabel.alpha = 1.0 }, completion: { _ in self.selectLabel.isHidden = false })
    }
    
    func hideSelectLabel() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { self.selectLabel.alpha = 0 }, completion: { _ in self.selectLabel.isHidden = true })
    }
}

//
//  CardView.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/04.
//

import UIKit

// TODO: 아이팟터치7세대에서 닫기버튼 view 와 다른 view 가 겹침. 이를 스크롤뷰나 priority 로 추후 수정해보기
class CardView: UIView {

    @IBOutlet weak var handle: UIView!
    @IBOutlet weak var commentAddBtn: UIButton!
    @IBOutlet weak var commentUpDownStackView: UIStackView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
        
        setUpViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
        setUpViews()
    }
    
    // MARK: - Method
    
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
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CardView", bundle: bundle)
        return nib.instantiate(
                    withOwner: self,
                    options: nil).first as? UIView
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        addSubview(view)
    }
}


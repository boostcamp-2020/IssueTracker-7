//
//  CardView.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/04.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var handle: UIView!
    @IBOutlet weak var commentAddBtn: UIButton!
    @IBOutlet weak var commentUpDownStackView: UIStackView!
    @IBOutlet weak var baseView: UIView!
    
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
        
        baseView.backgroundColor = UIColor.clear
        baseView.setUpShadow()
        
        commentUpDownStackView.layer.masksToBounds = true
        commentUpDownStackView.layer.cornerRadius = 5
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


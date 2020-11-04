//
//  CardView.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/04.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var handle: UIView!
    @IBOutlet weak var commentStack: UIStackView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    // MARK: - Method
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        handle.layer.masksToBounds = true
        handle.layer.cornerRadius = 3
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

//
//  IssueCellContentView.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/07.
//

import UIKit

class IssueCellContentView: UIView {
    
    // MARK: - Property
    
    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!
    @IBOutlet var milestone: UIButton!
    @IBOutlet weak var labelStackView: UIStackView!
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        xibSetup()
    }
    
    
    // MARK: - Method
    
    func initLabels() {
        labelStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    private func hexStringToUIColor (hex: String) -> UIColor {
        var rgbValue: UInt64 = 0
        let droppedString = hex.dropFirst()

        Scanner(string: String(droppedString)).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func configure(issueData: IssueData) {
        
        title.text = issueData.title
        // cell.content.text = // TODO: API 쪽에서 아직 구현이 안되서 추후 수정
        milestone.setTitle(issueData.milestone.title, for: .normal)
        
        issueData.labels?.forEach {
            let btn = UIButton()
            btn.setTitle(" \($0.name) ", for: .normal)
            btn.backgroundColor = hexStringToUIColor(hex: $0.color)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 15)
            btn.cornerRadius = 5
            
            labelStackView.addArrangedSubview(btn)
        }
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: IssueCellContentView.self), bundle: bundle)
        return nib.instantiate(
                    withOwner: self,
                    options: nil).first as? UIView
    }
    
    private func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        addSubview(view)
    }
    
}

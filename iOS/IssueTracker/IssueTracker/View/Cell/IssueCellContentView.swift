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
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var issueNumber: UILabel!
    
    
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
    
    func configure(issueInfo: IssueInfo) {
        
        title.text = issueInfo.title
        content.text = issueInfo.comments?.first?.content
        milestone.setTitle(issueInfo.milestone?.title, for: .normal)
        issueNumber.text = "#\(issueInfo.id)"
        
        if issueInfo.status == "open" {
            statusImageView.image = UIImage(systemName: "exclamationmark.circle")
            statusImageView.tintColor = .systemGreen
        } else {
            statusImageView.image = UIImage(systemName: "checkmark.circle")
            statusImageView.tintColor = .systemRed
        }
        
        
        issueInfo.labels?.forEach {
            let btn = UIButton()
            btn.setTitle("  \($0.name)  ", for: .normal)
            btn.backgroundColor = $0.color.hexStringToUIColor()
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
            btn.cornerRadius = 10
            
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

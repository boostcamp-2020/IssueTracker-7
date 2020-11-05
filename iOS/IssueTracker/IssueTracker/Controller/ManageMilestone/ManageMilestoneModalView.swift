//
//  ManageMilestoneModalView.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/05.
//

import UIKit

@IBDesignable
class ManageMilestoneModalView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}

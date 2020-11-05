//
//  ManageLabelModalView.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/04.
//

import UIKit

@IBDesignable
class ManageLabelModalView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}

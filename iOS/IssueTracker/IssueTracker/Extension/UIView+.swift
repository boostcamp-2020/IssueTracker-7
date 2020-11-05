//
//  UIView.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/04.
//

import UIKit

extension UIView {
    func setUpShadow(radius: CGFloat = 1.5, opacity: Float = 0.2) {
            
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
}

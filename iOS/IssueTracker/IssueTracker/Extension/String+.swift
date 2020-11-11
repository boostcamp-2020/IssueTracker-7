//
//  String+.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/05.
//

import UIKit

extension String {
    
    func matchesRegexPattern(_ pattern: String) throws -> Bool {
        
        return try NSRegularExpression(pattern: pattern, options: .caseInsensitive).firstMatch(in: self, options: [], range: _NSRange(location: 0, length: self.count)) == nil
    }
    
    func hexStringToUIColor () -> UIColor {
        var rgbValue: UInt64 = 0
        let droppedString = self.dropFirst()

        Scanner(string: String(droppedString)).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

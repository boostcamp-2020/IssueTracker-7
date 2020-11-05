//
//  UITextField+.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/05.
//

import UIKit

extension UITextField {
    @discardableResult
    func validatedText(validationType: ValidatorType) throws -> String {
        
        let validator = ValidatorFactory.validatorFor(type: validationType)
        return try validator.validate(self.text!)
    }
}

//
//  InputValidator.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/04.
//

import Foundation

protocol ValidatorConvertible {
    
    func validate(_ value: String) throws -> String
}

enum ValidatorType {
    
    case labelName, labelInfo, labelColor, milestoneName, milestoneDueDate, milestoneInfo, requiredField(field: String)
}

enum ValidatorFactory {
    
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        
        switch type {
        case .labelName:
            return LabelNameValidator()
        case .labelInfo:
            return LabelInfoValidator()
        case .labelColor:
            return LabelColorValidator()
        case .milestoneName:
            return MilestoneNameValidator()
        case .milestoneDueDate:
            return MilestoneDueDateValidator()
        case .milestoneInfo:
            return MilestoneInfoValidator()
        case .requiredField(field: let fieldName):
            return RequiredFieldValidator(fieldName)
        }
    }
}

class ValidationError: Error {
    
    var message: String
    
    init(_ message: String) {
        
        self.message = message
    }
}

private struct LabelNameValidator: ValidatorConvertible {
    
    func validate(_ value: String) throws -> String {
        
        guard value.trimmingCharacters(in: .whitespacesAndNewlines).count < 20
        else { throw ValidationError("레이블 이름은 20자 미만이어야 합니다.")}
        return value
    }
}

private struct LabelInfoValidator: ValidatorConvertible {
    
    func validate(_ value: String) throws -> String {
        
        guard value.trimmingCharacters(in: .whitespacesAndNewlines).count < 30
        else { throw ValidationError("레이블 설명은 30자 미만이어야 합니다.") }
        return value
    }
}

private struct LabelColorValidator: ValidatorConvertible {

    func validate(_ value: String) throws -> String {
        
        let matchError = ValidationError("올바른 16진수 색상 값이 아닙니다. 예) #93DAFF")
        let lengthError = ValidationError("# 특수문자를 포함하여 총 7자여야합니다. 예) #93DAFF")
        guard value.trimmingCharacters(in: .whitespacesAndNewlines).count <= 7 else { throw lengthError }
        
        do {
            if try value.trimmingCharacters(in: .whitespacesAndNewlines).matchesRegexPattern("#[0-9a-f]{6}") {
                throw matchError
            }
        } catch {
            throw matchError
        }
        return value
    }
}

private struct MilestoneNameValidator: ValidatorConvertible {
    
    func validate(_ value: String) throws -> String {
        
        guard value.trimmingCharacters(in: .whitespacesAndNewlines).count < 20
        else { throw ValidationError("마일스톤 이름은 20자 미만이어야 합니다.") }
        return value
    }
}

private struct MilestoneDueDateValidator: ValidatorConvertible {
    
    func validate(_ value: String) throws -> String {
        
        guard value.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else { return "" }
        
        let matchError = ValidationError("올바른 날짜 형식이 아닙니다. \n 예) 2020-11-05")
        do {
            if try value.trimmingCharacters(in: .whitespacesAndNewlines).matchesRegexPattern("[0-9]{4}-[0-9]{2}-[0-9]{2}") {
                throw matchError
            }
        } catch {
            throw matchError
        }
        return value
    }
}

private struct MilestoneInfoValidator: ValidatorConvertible {
    
    func validate(_ value: String) throws -> String {
        
        guard value.trimmingCharacters(in: .whitespacesAndNewlines).count < 30
        else { throw ValidationError("마일스톤 설명은 30자 미만이어야 합니다.") }
        return value
    }
}

private struct RequiredFieldValidator: ValidatorConvertible {
    
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validate(_ value: String) throws -> String {
        
        guard !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw ValidationError("\"\(fieldName)\" 은 필수항목입니다.")
        }
        return value
    }
}

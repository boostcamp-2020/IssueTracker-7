//
//  ManageMilestoneModalViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/05.
//

import UIKit

class ManageMilestoneModalViewController: UIViewController {
    
    @IBOutlet var secondTextFieldLabel: UILabel!
    
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var thirdTextField: UITextField!
    
    @IBOutlet var firstTextFieldErrorLabel: UILabel!
    @IBOutlet var secondTextFieldErrorLabel: UILabel!
    @IBOutlet var thirdTextFieldErrorLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeAllFields()
        configureTextField()
    }
    
}

// MARK: - 텍스트필드 설정

extension ManageMilestoneModalViewController {
    
    private func configureTextField() {
        
        let allTextFields: [UITextField] = [firstTextField, secondTextField, thirdTextField]
        
        allTextFields.forEach { textfield in
            textfield.addTarget(self, action: #selector(checkTextField(textfield:)), for: .editingChanged)
        }
    }
    
    @objc private func checkTextField (textfield: UITextField) {
        
        switch textfield {
        case firstTextField:
            do {
                try firstTextField.validatedText(validationType: .requiredField(field: "이름"))
                try firstTextField.validatedText(validationType: .milestoneName)
                firstTextFieldErrorLabel.text = ""
            } catch (let error) {
                firstTextFieldErrorLabel.text = (error as! ValidationError).message
            }
        case secondTextField:
            do {
                try secondTextField.validatedText(validationType: .milestoneDueDate)
                secondTextFieldErrorLabel.text = ""
                secondTextFieldLabel.textColor = UIColor.black
            } catch (let error) {
                secondTextFieldLabel.textColor = UIColor.systemRed
                secondTextFieldErrorLabel.text = (error as! ValidationError).message
            }
        case thirdTextField:
            do {
                try thirdTextField.validatedText(validationType: .milestoneInfo)
                thirdTextFieldErrorLabel.text = ""
            } catch (let error) {
                thirdTextFieldErrorLabel.text = (error as! ValidationError).message
            }
        default: break
        }
    }
}

// MARK: - IBActions

extension ManageMilestoneModalViewController {
    
    @IBAction func pressedClose(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func pressedInitialize(_ sender: UIButton) {
        
        initializeAllFields()
    }
    
    @IBAction func pressedSave(_ sender: UIButton) {
        
        do {
            try firstTextField.validatedText(validationType: .requiredField(field: "이름"))
            
            let _ = try firstTextField.validatedText(validationType: .milestoneName)
            let _ = try secondTextField.validatedText(validationType: .milestoneDueDate)
            let _ = try thirdTextField.validatedText(validationType: .milestoneInfo)
        } catch (let error) {
            alertValidationErrorOnSave(error: error)
            return
        }
        
        alertProceedSave()
        // TODO: alertProceedSave 안에서 OK 시 위의 3가지 값(milestoneName, milestoneDueDate, milestoneInfo)을 서버로 전송하기
    }
}

// MARK: - 경고창

extension ManageMilestoneModalViewController {
    
    private func alertProceedSave() {
        
        let saveAlert = UIAlertController(title: "알림", message: "마일스톤을 저장하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            // TODO: 값 저장하기
            self.dismiss(animated: true, completion: nil)
        }))
        
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(saveAlert, animated: true, completion: nil)
    }
    
    private func alertValidationErrorOnSave(error: Error) {
        
        let validationErrorAlert = UIAlertController(title: "잠깐! 🤗", message: (error as! ValidationError).message, preferredStyle: .alert)
        
        validationErrorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(validationErrorAlert, animated: true, completion: nil)
    }
}

// MARK: -

extension ManageMilestoneModalViewController {
    
    private func initializeAllFields() {
        
        firstTextField.text = ""
        secondTextField.text = ""
        thirdTextField.text = ""
        
        firstTextFieldErrorLabel.text = ""
        secondTextFieldErrorLabel.text = ""
        thirdTextFieldErrorLabel.text = ""
        
        secondTextFieldLabel.textColor = UIColor.black
    }
}

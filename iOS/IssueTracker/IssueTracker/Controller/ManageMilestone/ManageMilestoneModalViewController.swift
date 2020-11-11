//
//  ManageMilestoneModalViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/05.
//

import UIKit

protocol ManageMilestoneModalViewDelegate: AnyObject {
    func updateMilestone(milestone: MilestoneInfo)
    func addNewMilestone(milestone: MilestoneInfo)
}

class ManageMilestoneModalViewController: UIViewController {
    
    @IBOutlet var secondTextFieldLabel: UILabel!
    
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var thirdTextField: UITextField!
    
    @IBOutlet var firstTextFieldErrorLabel: UILabel!
    @IBOutlet var secondTextFieldErrorLabel: UILabel!
    @IBOutlet var thirdTextFieldErrorLabel: UILabel!
    
    private let api = BackEndAPIManager(router: Router())
    var milestoneInfo: MilestoneInfo? = nil
    weak var delegate: ManageMilestoneModalViewDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeAllFields(with: milestoneInfo)
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
        
        initializeAllFields(with: milestoneInfo)
    }
    
    @IBAction func pressedSave(_ sender: UIButton) {
        var milestoneName = ""
        var milestoneDueDate = ""
        var milestoneDescription = ""
        do {
            try firstTextField.validatedText(validationType: .requiredField(field: "이름"))
            
            milestoneName = try firstTextField.validatedText(validationType: .milestoneName)
            milestoneDueDate = try secondTextField.validatedText(validationType: .milestoneDueDate)
            milestoneDescription = try thirdTextField.validatedText(validationType: .milestoneInfo)
        } catch (let error) {
            alertValidationErrorOnSave(error: error)
            return
        }
        
        alertProceedSave(milestoneName: milestoneName, milestoneDueDate: milestoneDueDate, milestoneDescription: milestoneDescription)
    }
}

// MARK: - 경고창

extension ManageMilestoneModalViewController {
    
    private func alertProceedSave(milestoneName: String, milestoneDueDate: String, milestoneDescription: String) {
        
        let saveAlert = UIAlertController(title: "알림", message: "마일스톤을 저장하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            if self.milestoneInfo == nil {
                self.registerNewMilestone(milestoneName: milestoneName, milestoneDueDate: milestoneDueDate, milestoneDescription: milestoneDescription)
            } else {
                self.editExistingMilestone(milestoneName: milestoneName, milestoneDueDate: milestoneDueDate, milestoneDescription: milestoneDescription)
            }
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
    
    private func registerNewMilestone(milestoneName: String, milestoneDueDate: String, milestoneDescription: String) {
        
        api.addNewMilestone(milestoneName: milestoneName, milestoneDueDate: milestoneDueDate, milestoneDescription: milestoneDescription) { result in
            switch result {
            case .success(let milestone):
                DispatchQueue.main.async {
                    self.delegate?.addNewMilestone(milestone: milestone)
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func editExistingMilestone(milestoneName: String, milestoneDueDate: String, milestoneDescription: String) {
    
        guard let milestoneInfo = milestoneInfo else { return }
        api.editExistingMilestone(milestoneId: milestoneInfo.id, milestoneName: milestoneName, milestoneDueDate: milestoneDueDate, milestoneDescription: milestoneDescription) {
            result in

            switch result {
            case .success(let milestone):
                print(".success:", milestone)
                DispatchQueue.main.async {
                    self.delegate?.updateMilestone(milestone: milestone)
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func initializeAllFields(with: MilestoneInfo?) {
        
        firstTextField.text = (milestoneInfo?.title != nil) ? milestoneInfo?.title : ""
        secondTextField.text = (milestoneInfo?.dueDate != nil) ? milestoneInfo?.dueDate : ""
        thirdTextField.text = ""
        
        firstTextFieldErrorLabel.text = ""
        secondTextFieldErrorLabel.text = ""
        thirdTextFieldErrorLabel.text = ""
        
        secondTextFieldLabel.textColor = UIColor.black
    }
}

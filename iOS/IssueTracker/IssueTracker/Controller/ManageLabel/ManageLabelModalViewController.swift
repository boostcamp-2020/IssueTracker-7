//
//  ModalVIewControllerViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/04.
//

import UIKit

protocol ManageLabelModalViewDelegate: AnyObject {
    func updateLabel(label: LabelInfo)
    func addNewLabel(label: LabelInfo)
}

final class ManageLabelModalViewController: UIViewController {
    
    
    @IBOutlet var firstTextFieldLabel: UILabel!
    @IBOutlet var secondTextFieldLabel: UILabel!
    @IBOutlet var thirdTextFieldLabel: UILabel!
    
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var thirdTextField: UITextField!
    
    @IBOutlet var firstTextFieldErrorLabel: UILabel!
    @IBOutlet var secondTextFieldErrorLabel: UILabel!
    @IBOutlet var thirdTextFieldErrorLabel: UILabel!
    
    @IBOutlet var colorPicker: UIButton!
    
    private let api = BackEndAPIManager(router: Router())
    private var initialLabelColor = UIColor.systemOrange
    
    let colorPickerViewController = UIColorPickerViewController()
    var labelInfo: LabelInfo? = nil
    weak var delegate: ManageLabelModalViewDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeAllFields(with: labelInfo)
        configureColorPicker()
        configureTextField()
    }
    
}

// MARK: - 텍스트필드 설정
extension ManageLabelModalViewController {
    
    private func configureTextField() {
        
        firstTextField.addTarget(self, action: #selector(checkTextField(textfield:)), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(checkTextField(textfield:)), for: .editingChanged)
        thirdTextField.addTarget(self, action: #selector(checkTextField(textfield:)), for: .editingChanged)
    }
    
    @objc private func checkTextField (textfield: UITextField) {
        
        switch textfield {
        case firstTextField:
            do {
                try firstTextField.validatedText(validationType: .requiredField(field: "이름"))
                try firstTextField.validatedText(validationType: .labelName)
                firstTextFieldErrorLabel.text = ""
            } catch (let error) {
                firstTextFieldErrorLabel.text = (error as! ValidationError).message
            }
        case secondTextField:
            do {
                try secondTextField.validatedText(validationType: .requiredField(field: "설명"))
                try secondTextField.validatedText(validationType: .labelInfo)
                secondTextFieldErrorLabel.text = ""
            } catch (let error) {
                secondTextFieldErrorLabel.text = (error as! ValidationError).message
            }
        case thirdTextField:
            do {
                try thirdTextField.validatedText(validationType: .requiredField(field: "색상"))
                let validatedLabelColor = try thirdTextField.validatedText(validationType: .labelColor)
                guard let color = UIColor(hex: validatedLabelColor) else { return }
                thirdTextFieldErrorLabel.text = ""
                colorPicker.backgroundColor = color
                colorPickerViewController.selectedColor = color
            } catch (let error) {
                thirdTextFieldErrorLabel.text = (error as! ValidationError).message
            }
        default: break
        }
    }
}

// MARK: - IBActions
extension ManageLabelModalViewController {
    
    @IBAction func pressedColorPicker(_ sender: UIButton) {
        
        present(colorPickerViewController, animated: true, completion: nil)
    }
    
    @IBAction func pressedClose(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedRandomColorGenerator(_ sender: UIButton) {
        
        let hexColorString = randomHexColorString()
        let randomColor = UIColor(hex: hexColorString)!
        thirdTextField.text = hexColorString
        thirdTextFieldErrorLabel.text = ""
        colorPicker.backgroundColor = randomColor
        colorPickerViewController.selectedColor = randomColor
    }
    
    @IBAction func pressedInitialize(_ sender: UIButton) {
        
        initializeAllFields(with: labelInfo)
    }
    
    @IBAction func pressedSave(_ sender: UIButton) {
        var labelName = ""
        var labelInfo = ""
        var labelColor = ""
        do {
            try firstTextField.validatedText(validationType: .requiredField(field: "이름"))
            try secondTextField.validatedText(validationType: .requiredField(field: "설명"))
            try thirdTextField.validatedText(validationType: .requiredField(field: "색상"))
            
            labelName = try firstTextField.validatedText(validationType: .labelName)
            labelInfo = try secondTextField.validatedText(validationType: .labelInfo)
            labelColor = try thirdTextField.validatedText(validationType: .labelColor)
        } catch (let error) {
            alertValidationErrorOnSave(error: error)
            return
        }
        alertProceedSave(labelName: labelName, labelDescription: labelInfo, labelColor: labelColor)
        // TODO: alertProceedSave 안에서 OK 시 위의 3가지 값(labelName, labelInfo, labelColor)을 서버로 전송하기
    }
}

// MARK: - 경고창
extension ManageLabelModalViewController {
    
    private func alertProceedSave(labelName: String, labelDescription: String, labelColor: String) {
        
        let saveAlert = UIAlertController(title: "알림", message: "레이블을 저장하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            if self.labelInfo == nil {
                self.registerNewLabel(labelName: labelName, labelDescription: labelDescription, labelColor: labelColor)
            } else {
                self.editExistingLabel(labelName: labelName, labelDescription: labelDescription, labelColor: labelColor)
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
extension ManageLabelModalViewController {
    
    private func editExistingLabel(labelName: String, labelDescription: String, labelColor: String) {
        
        guard let labelInfo = labelInfo else { return }
        api.editExistingLabel(labelId: labelInfo.id, labelName: labelName, labelDescription: labelDescription, labelColor: labelColor) {
            result in

            switch result {
            case .success(let label):
                print(".success:", label)
                DispatchQueue.main.async {
                    self.delegate?.updateLabel(label: label)
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func registerNewLabel(labelName: String, labelDescription: String, labelColor: String) {
        api.addNewLabel(labelName: labelName, labelDescription: labelDescription, labelColor: labelColor) { result in
            switch result {
            case .success(let label):
                DispatchQueue.main.async {
                    self.delegate?.addNewLabel(label: label)
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func initializeAllFields(with: LabelInfo?) {
        
        initialLabelColor = (labelInfo?.color != nil) ? UIColor.init(hex: labelInfo?.color ?? "#FF9500")! : initialLabelColor
        
        firstTextField.text = (labelInfo?.name != nil) ? labelInfo?.name : ""
        secondTextField.text = (labelInfo?.description != nil) ? labelInfo?.description : ""
        thirdTextField.text = initialLabelColor.toHex
        
        firstTextFieldErrorLabel.text = ""
        secondTextFieldErrorLabel.text = ""
        thirdTextFieldErrorLabel.text = ""
        
        colorPicker.backgroundColor = initialLabelColor
        colorPickerViewController.selectedColor = initialLabelColor
    }
    
    private func randomHexColorString() -> String {
        
        let digits: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]
        
        var hexCode = "#"
        
        while (hexCode.count < 7) {
            hexCode += digits.randomElement()!
        }
        
        return hexCode.uppercased()
    }
    private func configureColorPicker() {
        
        colorPickerViewController.delegate = self
        colorPickerViewController.supportsAlpha = false
        colorPickerViewController.selectedColor = initialLabelColor
    }
}

// MARK: - UIColorPickerViewController 설정
extension ManageLabelModalViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        
        colorPicker.backgroundColor =  viewController.selectedColor
        thirdTextField.text = viewController.selectedColor.toHex
    }
}

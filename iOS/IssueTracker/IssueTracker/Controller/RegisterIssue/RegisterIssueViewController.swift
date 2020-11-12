//
//  ViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/02.
//

import UIKit
import MarkdownView

final class RegisterIssueViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentView: UIView!
    @IBOutlet var markdownTextView: UITextView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var titleTextFieldErrorLabel: UILabel!
    
    var imageView: UIImageView!
    var markdownView: MarkdownView!
    var imagePicker = UIImagePickerController()
    
    private let api = BackEndAPIManager(router: Router())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextArea()
        addCustomMenu()
    }
    
    @IBAction func pressedDone(_ sender: UIButton) {
        var title = ""
        
        do {
            title = try titleTextField.validatedText(validationType: .requiredField(field: "제목"))
        } catch (let error) {
            alertValidationErrorOnSave(error: error)
            return
        }
     
        alertProceedSave(title: title, content: markdownTextView.text)
    }
    
    private func alertProceedSave(title: String, content: String) {
        
        let saveAlert = UIAlertController(title: "알림", message: "이슈을 저장하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.registerNewIssue(title: title, content: content)

            self.dismiss(animated: true, completion: nil)
        }))
        
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(saveAlert, animated: true, completion: nil)

    }
    
    private func registerNewIssue(title: String, content: String) {
        
        api.addNewIssue(title: title, content: content) { result in
            switch result {
            case .success(let issue):
                print(".success:", issue)
                DispatchQueue.main.async {
                    // TODO: 새 이슈를 이슈목록에 반영하기 .. delegate 사용?
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    private func alertValidationErrorOnSave(error: Error) {
        
        let validationErrorAlert = UIAlertController(title: "잠깐! 🤗", message: (error as! ValidationError).message, preferredStyle: .alert)
        
        validationErrorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(validationErrorAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func pressedClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedSegmentedControl(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0: switchView(markdownTextView)
        case 1:
            markdownView = MarkdownView()
            markdownView.load(markdown: markdownTextView.text)
            switchView(markdownView)
        default: break;
        }
    }
    
    func configureTextArea() {
        
        titleTextField.addTarget(self, action: #selector(checkTitleTextField(textfield:)), for: .editingChanged)
    }
    
    @objc private func checkTitleTextField (textfield: UITextField) {
        
        do {
            try textfield.validatedText(validationType: .requiredField(field: "제목"))
            titleTextFieldErrorLabel.text = ""
        } catch (let error) {
            titleTextFieldErrorLabel.text = (error as! ValidationError).message
        }
    }
    
    func switchView(_ view: UIView) {
        
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            view.topAnchor.constraint(equalTo: contentView.topAnchor), view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func addCustomMenu() {
        let print = UIMenuItem(title: "Insert Photo", action: #selector(openImagePicker))
        UIMenuController.shared.menuItems = [print]
    }
    
    @objc func openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension RegisterIssueViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            // 아래 이미지를 서버로 보낸 후, 해당 이미지가 저장되어있는 URL을 받고 textview에 추가.
            imageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

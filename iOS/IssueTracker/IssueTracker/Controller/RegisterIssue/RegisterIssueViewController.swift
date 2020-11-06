//
//  ViewController.swift
//  IssueTracker
//
//  Created by Imho Jang on 2020/11/02.
//

import UIKit
import MarkdownView

final class RegisterIssueViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var markdownTextView: UITextView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var imageView: UIImageView!
    var markdownView: MarkdownView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCustomMenu()
    }
    
    @IBAction func pressedDone(_ sender: UIButton) {
        // 완료 버튼 누를 시 저장하고 화면을 닫는다.
        dismiss(animated: true, completion: nil)
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

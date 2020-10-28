//
//  AppleSignInButton.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/28.
//

import UIKit
import AuthenticationServices

class AppleSignInButton: UIView {
    
    weak var delegate: (ASAuthorizationControllerDelegate & ASAuthorizationControllerPresentationContextProviding)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupProviderLoginView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProviderLoginView()
    }
    
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        addSubview(authorizationButton)
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email] // 최초에 한 번만
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = delegate
        authorizationController.presentationContextProvider = delegate
        authorizationController.performRequests()
    }
    
    
}

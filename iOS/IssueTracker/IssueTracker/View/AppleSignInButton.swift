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
    let authorizationButton = ASAuthorizationAppleIDButton()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupProviderLoginView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProviderLoginView()
    }
  
    func setupProviderLoginView() {
        authorizationButton.frame = bounds
        
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        addSubview(authorizationButton)

        authorizationButton.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 제약이 잡히기 전이기 때문에 미리 설정해줘야 한다.
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

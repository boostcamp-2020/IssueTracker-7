//
//  ViewController.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import UIKit
import AuthenticationServices

class SignInController: UIViewController {
    
    private var oauth: OAuthManager?
    @IBOutlet weak var signInAppleButton: AppleSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInAppleButton.delegate = self
    }
    
    @IBAction func githubLogin(_ sender: Any) {
        oauth = OAuthManager(oauth: GithubLoginManager())
        oauth?.requestAuthorization()
    }
}

extension SignInController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let userFullName = appleIDCredential.fullName?.givenName
            let userEmail = appleIDCredential.email
            
            print(userIdentifier, userFullName, userEmail)
            // 애플 로그인시, 여기서 유저 정보를 백엔드로 보냄
            
            //Navigate to other view controller
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            print(username, password)
            //Navigate to other view controller
        }
      }
      
      func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // handle Error.
      }
}

extension SignInController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
}

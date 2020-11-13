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
        let handler = {
            DispatchQueue.main.async {
                self.loginSuccess()
            }
        }
        oauth = OAuthManager(oauth: BackEndOAuthManager(router: Router()), handler: handler)
        oauth?.requestAuthorization()
    }
}

// MARK: - Extension

// MARK: NotificationCenter selectors
extension SignInController {
    
    func setUpTransitionStyle() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
    }
    
    @objc func loginSuccess() {
        // notification 오는 경우 로그인 성공으로 간주, 여기서 다음 화면으로 전환
        let storyboard: UIStoryboard = UIStoryboard(name: StoryboardID.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: StoryboardID.initialTabBarController
        )
        
        viewController.modalPresentationStyle = .fullScreen
        setUpTransitionStyle()
        view.window?.rootViewController = viewController
    }
}

extension SignInController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let userFullName = appleIDCredential.fullName?.givenName
            let userEmail = appleIDCredential.email
            
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
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

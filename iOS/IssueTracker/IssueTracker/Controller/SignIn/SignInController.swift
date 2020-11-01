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
        setUpNotificationCenter()
    }
    
    func setUpNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: Notification.Name.loginSuccessReceived, object: nil)
    }
    
    @IBAction func githubLogin(_ sender: Any) {
        let handler = {
            DispatchQueue.main.async {
                self.loginSuccess()
            }
        }
        oauth = OAuthManager(oauth: GithubOAuthManager(), handler: handler)
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
        let storyboard: UIStoryboard = UIStoryboard(name: StoryboardName.issueList, bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: StoryboardName.issueListStoryboardInitialViewController
        )
        
        viewController.modalPresentationStyle = .fullScreen
        setUpTransitionStyle() // TODO: transition 공부하고 좀 더 수정해보기
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

//
//  SceneDelegate.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        // 백엔드 서버로부터 토큰, 유저 정보 오는 곳. UserInfo 구조체에 저장 후 signincontroller 로 notification
//        NotificationCenter.default.post(name: Notification.Name.userInfoReceived, object: nil)
        
        if let url = URLContexts.first?.url {
            print(url)
            let stringURL = String(describing: url)
            guard let accessToken = stringURL.accessToken(),
                  let refreshToken = stringURL.refreshToken() else { return }
            UserInfo.shared.accessToken = accessToken
            UserInfo.shared.refreshToken = refreshToken
            
            print(UserInfo.shared.accessToken)
            print(UserInfo.shared.refreshToken)
            
            NotificationCenter.default.post(name: Notification.Name.backEndTokenReceived, object: nil)
        }
    }

    func autoLogin(scene: UIScene) {
        // 토큰 정보가 있을 시 자동 로그인
//        guard UserInfo.shared.isAllInfoExisted() else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let storyboard: UIStoryboard = UIStoryboard(name: StoryboardID.main, bundle: nil)
        let initViewController = storyboard.instantiateViewController(withIdentifier: StoryboardID.initialTabBarController)
        
        window?.rootViewController = initViewController
        window?.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        UserInfo.shared.accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsInR5cGUiOiJnaXRodWIiLCJ1c2VyX2lkIjoic2VvdWxib3kiLCJpYXQiOjE2MDUyNTM1MDZ9.vs5tDYZzpjNqiCugU1Tv6G1-pyOC5Hv4OaaCj3hdaIo"
        autoLogin(scene: scene)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


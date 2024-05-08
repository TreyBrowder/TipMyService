//
//  SceneDelegate.swift
//  TipMyService
//
//  Created by Trey Browder on 5/8/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        let vc = HomeViewController()
        window.rootViewController = vc
        self.window = window
        window.makeKeyAndVisible()
    }

}


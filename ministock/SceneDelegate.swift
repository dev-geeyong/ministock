//
//  SceneDelegate.swift
//  ministock
//
//  Created by IT on 2022/02/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        self.window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = MainTapBarController()
        window?.makeKeyAndVisible()
    }
}


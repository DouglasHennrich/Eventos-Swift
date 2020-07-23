//
//  SceneDelegate.swift
//  Eventos
//
//  Created by Douglas Hennrich on 21/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        appCoordinator = AppCoordinator()
        appCoordinator?.start()

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = appCoordinator?.navigationController
        window?.makeKeyAndVisible()
    }

}

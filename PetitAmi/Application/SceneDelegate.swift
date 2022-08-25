//
//  SceneDelegate.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/18/22.
//

import FirebaseAuth
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        let navController = isUserLogged() ? UINavigationController(rootViewController: TabBarViewController()) : UINavigationController(rootViewController: FirstViewController())
        setupNavigationController(navController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

//    func start() {
//        var vc: UIViewController & Coordinating = isUserLogged() ? TabBarViewController() : FirstViewController()
//        vc.coodinator = self
//        navigationController?.setViewControllers([vc], animated: false)
//        setLightBackArrow()
//    }
//

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

    private func isUserLogged() -> Bool {
        Auth.auth().currentUser != nil
    }

    private func setupNavigationController(_ nav: UINavigationController) {
        nav.navigationBar.tintColor = .white
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.standardAppearance.backgroundColor = .clear
        nav.navigationBar.standardAppearance.backgroundEffect = .none
        nav.navigationBar.standardAppearance.shadowColor = .clear
    }
}


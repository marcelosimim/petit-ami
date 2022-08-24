//
//  MainCoordinator.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/18/22.
//

import FirebaseAuth
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?

    func eventOccurred(with type: Event) {
        switch type {
        case .signInTapped:
            var vc: UIViewController & Coordinating = LoginViewController()
            vc.coodinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .signUpTapped:
            var vc: UIViewController & Coordinating = RegisterViewController()
            vc.coodinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .authSuccess:
            var vc: UIViewController & Coordinating = TabBarViewController()
            vc.coodinator = self
            navigationController?.pushViewController(vc, animated: true)
            // hide back button 
        case .exerciseTapped:
            var vc: UIViewController & Coordinating = ExerciseViewController()
            vc.coodinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func start() {
        var vc: UIViewController & Coordinating = isUserLogged() ? TabBarViewController() : FirstViewController()
        vc.coodinator = self
        navigationController?.setViewControllers([vc], animated: false)
        setLightBackArrow()
    }

    private func isUserLogged() -> Bool {
        Auth.auth().currentUser != nil
    }

    private func setLightBackArrow() {
        navigationController?.navigationBar.tintColor = .white
    }
}

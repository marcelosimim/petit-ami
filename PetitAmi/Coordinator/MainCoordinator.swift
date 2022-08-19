//
//  MainCoordinator.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/18/22.
//

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
        }
    }

    func start() {
        var vc: UIViewController & Coordinating = FirstViewController()
        vc.coodinator = self
        navigationController?.setViewControllers([vc], animated: false)
        setLightBackArrow()
    }

    private func setLightBackArrow() {
        navigationController?.navigationBar.tintColor = .white
    }
}

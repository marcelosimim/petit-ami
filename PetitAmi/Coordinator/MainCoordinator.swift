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
            break
        case .signUpTapped:
            break
        }
    }

    func start() {
        var vc: UIViewController & Coordinating = FirstViewController()
        vc.coodinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }

    private func setLightBackArrow() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .clear
    }
}

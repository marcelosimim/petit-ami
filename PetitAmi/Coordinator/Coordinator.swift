//
//  Coordinator.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/18/22.
//

import UIKit

enum Event {
    case signInTapped
    case signUpTapped
    case authSuccess
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }

    func eventOccurred(with type: Event)
    func start()
}

protocol Coordinating {
    var coodinator: Coordinator? { get set }
}

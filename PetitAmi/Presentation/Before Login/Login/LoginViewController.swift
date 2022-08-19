//
//  LoginViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import UIKit

class LoginViewController: UIViewController, Coordinating {
    var coodinator: Coordinator?
    private let loginView = AppContainer.shared.resolve(LoginView.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView.contentView
    }
}

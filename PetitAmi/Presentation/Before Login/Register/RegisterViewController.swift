//
//  RegisterViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import UIKit

class RegisterViewController: UIViewController, Coordinating {
    var coodinator: Coordinator?
    private let registerView = AppContainer.shared.resolve(RegisterView.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        view = registerView.contentView
    }
}

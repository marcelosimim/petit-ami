//
//  ViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/18/22.
//

import UIKit

class FirstViewController: UIViewController {
    private let firstView = AppContainer.shared.resolve(FirstView.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        view = firstView.contentView
        navigationItem.hidesBackButton = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupButtons()
    }

    private func setupButtons() {
        firstView.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        firstView.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }

    @objc private func didTapSignIn() {
        print(navigationController)
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }

    @objc private func didTapSignUp() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}


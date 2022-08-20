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
    private let viewModel = AppContainer.shared.resolve(LoginViewModel.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView.contentView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupButton()
        setupTextFields()
        observerViewModel()
    }

    private func setupButton() {
        loginView.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }

    private func setupTextFields() {
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }

    private func observerViewModel() {
        viewModel.emailHasError.bind { hasError in
            hasError ? self.loginView.emailTextField.hasErrorState() : self.loginView.emailTextField.defaultState()
        }
        viewModel.passwordHasError.bind { hasError in
            hasError ? self.loginView.passwordTextField.hasErrorState() : self.loginView.passwordTextField.defaultState()
        }
        viewModel.isButtonEnabled.bind { isEnabled in
            self.loginView.signInButton.isEnabled = isEnabled
        }
    }

    @objc private func didTapSignIn() {
        viewModel.login() { error in
            if let error = error {
                Alert.alertToCorrect(title: "Erro ao logar", message: error.localizedDescription, controller: self)
            } else {
                self.coodinator?.eventOccurred(with: .authSuccess)
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textField = textField as? InputTextField, let type = textField.type else { return true }

        viewModel.textFieldShouldReturn(textField.text, type: type)
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? InputTextField, let type = textField.type else { return }
        viewModel.textFieldDidBeginEditing(type: type)
    }
}

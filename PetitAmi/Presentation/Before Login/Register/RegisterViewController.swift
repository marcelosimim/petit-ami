//
//  RegisterViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import UIKit

class RegisterViewController: UIViewController {
    private let registerView = AppContainer.shared.resolve(RegisterView.self)!
    private let viewModel = AppContainer.shared.resolve(RegisterViewModel.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        view = registerView.contentView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupButton()
        setupTextFields()
        observerViewModel()
    }

    private func setupButton() {
        registerView.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }

    private func setupTextFields() {
        registerView.nameTextField.delegate = self
        registerView.emailTextField.delegate = self
        registerView.passwordTextField.delegate = self
        registerView.confirmPasswordTextField.delegate = self
    }

    private func observerViewModel() {
        viewModel.nameHasError.bind { hasError in
            hasError ? self.registerView.nameTextField.hasErrorState() : self.registerView.nameTextField.defaultState()
        }
        viewModel.emailHasError.bind { hasError in
            hasError ? self.registerView.emailTextField.hasErrorState() : self.registerView.emailTextField.defaultState()
        }
        viewModel.passwordHasError.bind { hasError in
            hasError ? self.registerView.passwordTextField.hasErrorState() : self.registerView.passwordTextField.defaultState()
        }
        viewModel.confirmPasswordHasError.bind { hasError in
            hasError ? self.registerView.confirmPasswordTextField.hasErrorState() : self.registerView.confirmPasswordTextField.defaultState()
        }
        viewModel.isButtonEnabled.bind { isEnabled in
            self.registerView.signUpButton.isEnabled = isEnabled
        }
    }

    @objc private func didTapSignUp() {
        viewModel.register() { error in
            if let error = error {
                Alert.alertToCorrect(title: "Erro ao cadastrar", message: error.localizedDescription, controller: self)
            } else {
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
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

//
//  RegisterView.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import UIKit

protocol RegisterView {
    var contentView: UIView { get }
    var nameTextField: InputTextField { get }
    var emailTextField: InputTextField { get }
    var passwordTextField: InputTextField { get }
    var confirmPasswordTextField: InputTextField { get }
    var signUpButton: PrimaryButton { get }
}

class DefaultRegisterView: RegisterView {
    var contentView = UIView()
    var nameTextField = InputTextField()
    var emailTextField = InputTextField()
    var passwordTextField = InputTextField()
    var confirmPasswordTextField = InputTextField()
    var signUpButton = PrimaryButton()

    init() {
        setupStyles()
        addViews()
        setupTextFields()
    }

    func addViews() {
        contentView.addSubviews([nameTextField, emailTextField, passwordTextField, confirmPasswordTextField, signUpButton])

        nameTextField.topToTop(of: contentView, margin: .vertical128)
        nameTextField.centerHorizontal(to: contentView)
        nameTextField.leadingToLeading(of: contentView, margin: .leadingMargin)
        nameTextField.heightTo(.textFieldHeight)

        emailTextField.topToBottom(of: nameTextField, margin: .vertical16)
        emailTextField.centerHorizontal(to: contentView)
        emailTextField.leadingToLeading(of: contentView, margin: .leadingMargin)
        emailTextField.heightTo(.textFieldHeight)

        passwordTextField.topToBottom(of: emailTextField, margin: .vertical16)
        passwordTextField.centerHorizontal(to: contentView)
        passwordTextField.leadingToLeading(of: contentView, margin: .leadingMargin)
        passwordTextField.heightTo(.textFieldHeight)

        confirmPasswordTextField.topToBottom(of: passwordTextField, margin: .vertical16)
        confirmPasswordTextField.centerHorizontal(to: contentView)
        confirmPasswordTextField.leadingToLeading(of: contentView, margin: .leadingMargin)
        confirmPasswordTextField.heightTo(.textFieldHeight)

        signUpButton.centerHorizontal(to: contentView)
        signUpButton.leadingToLeading(of: contentView, margin: .leadingMargin)
        signUpButton.bottomToBottom(of: contentView, margin: .vertical128)
    }

    private func setupTextFields() {
        nameTextField.setup(type: .name)
        emailTextField.setup(type: .email)
        passwordTextField.setup(type: .password)
        confirmPasswordTextField.setup(type: .confirmPassword)
    }
}

extension DefaultRegisterView: Stylable {
    func setupColors() {
        contentView.backgroundColor = .background
    }

    func setupTexts() {
        signUpButton.setup(title: "Cadastrar")
    }
}

//
//  LoginView.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Foundation

import UIKit

protocol LoginView {
    var contentView: UIView { get }
    var emailTextField: InputTextField { get }
    var passwordTextField: InputTextField { get }
    var signInButton: PrimaryButton { get }
}

class DefaultLoginView: LoginView {
    var contentView = UIView()
    var emailTextField = InputTextField()
    var passwordTextField = InputTextField()
    var signInButton = PrimaryButton()

    init() {
        setupStyles()
        addViews()
        setupTextFields()
        signInButton.isEnabled = false
    }

    func addViews() {
        contentView.addSubviews([emailTextField, passwordTextField, signInButton])

        emailTextField.bottomToTop(of: passwordTextField, margin: .vertical16)
        emailTextField.centerHorizontal(to: contentView)
        emailTextField.leadingToLeading(of: contentView, margin: .leadingMargin)
        emailTextField.heightTo(.textFieldHeight)

        passwordTextField.centerVertical(to: contentView)
        passwordTextField.centerHorizontal(to: contentView)
        passwordTextField.leadingToLeading(of: contentView, margin: .leadingMargin)
        passwordTextField.heightTo(.textFieldHeight)

        signInButton.centerHorizontal(to: contentView)
        signInButton.leadingToLeading(of: contentView, margin: .leadingMargin)
        signInButton.topToBottom(of: passwordTextField, margin: .vertical64)
    }

    private func setupTextFields() {
        emailTextField.setup(type: .email)
        passwordTextField.setup(type: .password)
    }

}

extension DefaultLoginView: Stylable {
    func setupColors() {
        contentView.backgroundColor = .background
    }

    func setupTexts() {
        signInButton.setup(title: "Entrar")
    }
}

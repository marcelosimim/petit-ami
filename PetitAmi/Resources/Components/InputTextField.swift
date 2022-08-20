//
//  InputTextField.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import UIKit

enum InputTextFieldType {
    case name
    case email
    case password
    case confirmPassword
}

class InputTextField: UITextField {
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    var type: InputTextFieldType?

    func setup(type: InputTextFieldType) {
        self.type = type
        setBorder()
        defaultState()
        setupStyles()
        switch type {
        case .name:
            setupName()
        case .email:
            setupEmail()
        case .password:
            setupPassword()
        case .confirmPassword:
            setupConfirmPassword()
        }
    }

    private func setBorder() {
        layer.borderWidth = 1
        layer.cornerRadius = 10
    }

    private func setupName() {
        attributedPlaceholder = NSAttributedString(
            string: "Insira o nome",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.darker(by: 30)]
        )
        autocapitalizationType = .none
    }

    private func setupEmail() {
        attributedPlaceholder = NSAttributedString(
            string: "Insira o email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.darker(by: 30)]
        )
        autocapitalizationType = .none
        keyboardType = .emailAddress
    }

    private func setupPassword() {
        attributedPlaceholder = NSAttributedString(
            string: "Insira a senha",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.darker(by: 30)]
        )
        isSecureTextEntry = true
    }

    private func setupConfirmPassword() {
        attributedPlaceholder = NSAttributedString(
            string: "Confirme a senha",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.darker(by: 30)]
        )
        isSecureTextEntry = true
    }

    func hasErrorState() {
        textColor = .red
        layer.borderColor = UIColor.red.cgColor
    }

     func defaultState() {
        textColor = .white
        layer.borderColor = UIColor.background.cgColor
    }
}

extension InputTextField {
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension InputTextField: Stylable {
    func setupColors() {
        backgroundColor = .darkBlue
    }
}

//
//  LoginViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Foundation

protocol LoginViewModel {
    var emailHasError: Observable<Bool> { get }
    var passwordHasError: Observable<Bool> { get }
    var isButtonEnabled: Observable<Bool> { get }

    func login(completion: @escaping(Error?) -> Void)
    func textFieldShouldReturn(_ text: String?, type: InputTextFieldType)
    func textFieldDidBeginEditing(type: InputTextFieldType)
}

class DefaultLoginViewModel: LoginViewModel {
    private let loginUseCase: LoginUseCase
    var emailHasError = Observable<Bool>(false)
    var passwordHasError = Observable<Bool>(false)
    var isButtonEnabled = Observable<Bool>(false)
    private var emailValue = ""
    private var passwordValue = ""
    private var emailIsValid = false
    private var passwordIsValid = false

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    func login(completion: @escaping(Error?) -> Void) {
        loginUseCase.login(email: emailValue, password: passwordValue, completion: completion)
    }

    func textFieldShouldReturn(_ text: String?, type: InputTextFieldType) {
        switch type {
        case .email:
            emailValue = text ?? ""
            emailHasError.value = !isValidEmail(text)
            emailIsValid = !emailHasError.value
        case .password:
            passwordValue = text ?? ""
            passwordHasError.value = !isPasswordValid(text)
            passwordIsValid = !passwordHasError.value
        case .name, .confirmPassword, .answer:
           break
        }
        isButtonEnabled.value = isAllFieldsValid()
    }

    func textFieldDidBeginEditing(type: InputTextFieldType) {
        switch type {
        case .email:
            emailHasError.value = false
            emailIsValid = false
        case .password:
            passwordHasError.value = false
            passwordIsValid = false
        case .name, .confirmPassword, .answer:
           break
        }
        isButtonEnabled.value = false
    }

    private func isAllFieldsValid() -> Bool {
        emailIsValid && passwordIsValid
    }

    private func isValidEmail(_ text: String?) -> Bool {
        guard let text = text else { return false }
        return text.isValidEmail()
    }

    private func isPasswordValid(_ text: String?) -> Bool {
        guard let text = text else { return false }
        return text.count >= 6
    }
}

//
//  RegisterViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Foundation

protocol RegisterViewModel {
    var nameHasError: Observable<Bool> { get }
    var emailHasError: Observable<Bool> { get }
    var passwordHasError: Observable<Bool> { get }
    var confirmPasswordHasError: Observable<Bool> { get }
    var isButtonEnabled: Observable<Bool> { get }

    func register(completion: @escaping(Error?) -> Void)
    func textFieldShouldReturn(_ text: String?, type: InputTextFieldType)
    func textFieldDidBeginEditing(type: InputTextFieldType)
}

class DefaultRegisterViewModel: RegisterViewModel {
    private let registerUseCase: RegisterUseCase
    var nameHasError = Observable<Bool>(false)
    var emailHasError = Observable<Bool>(false)
    var passwordHasError = Observable<Bool>(false)
    var confirmPasswordHasError = Observable<Bool>(false)
    var isButtonEnabled = Observable<Bool>(false)
    private var nameValue = ""
    private var emailValue = ""
    private var passwordValue = ""
    private var confirmPasswordValue = ""
    private var nameIsValid = false
    private var emailIsValid = false
    private var passwordIsValid = false
    private var confirmPasswordIsValid = false

    init(registerUseCase: RegisterUseCase) {
        self.registerUseCase = registerUseCase
    }

    func register(completion: @escaping(Error?) -> Void) {
        let user = User(name: nameValue, unit: 1, exercise: 1)
        registerUseCase.register(user: user.toModel(), email: emailValue, password: passwordValue, completion: completion)
    }

    func textFieldShouldReturn(_ text: String?, type: InputTextFieldType) {
        switch type {
        case .name:
            nameValue = text ?? ""
            nameHasError.value = isFieldEmpty(text)
            nameIsValid = !nameHasError.value
        case .email:
            emailValue = text ?? ""
            emailHasError.value = !isValidEmail(text)
            emailIsValid = !emailHasError.value
        case .password:
            passwordValue = text ?? ""
            passwordHasError.value = !isPasswordValid(text)
            passwordIsValid = !passwordHasError.value
        case .confirmPassword:
            confirmPasswordValue = text ?? ""
            confirmPasswordHasError.value = !isEqual(text, passwordValue)
            confirmPasswordIsValid = !confirmPasswordHasError.value
        }
        isButtonEnabled.value = isAllFieldsValid()
    }

    func textFieldDidBeginEditing(type: InputTextFieldType) {
        switch type {
        case .name:
            nameHasError.value = false
            nameIsValid = false
        case .email:
            emailHasError.value = false
            emailIsValid = false
        case .password:
            passwordHasError.value = false
            passwordIsValid = false
        case .confirmPassword:
            confirmPasswordHasError.value = false
            confirmPasswordIsValid = false
        }
        isButtonEnabled.value = false
    }

    private func isAllFieldsValid() -> Bool {
        nameIsValid && emailIsValid && passwordIsValid && confirmPasswordIsValid
    }

    private func isFieldEmpty(_ text: String?) -> Bool {
        guard let text = text else { return false }
        return text.isEmpty
    }

    private func isValidEmail(_ text: String?) -> Bool {
        guard let text = text else { return false }
        return text.isValidEmail()
    }

    private func isPasswordValid(_ text: String?) -> Bool {
        guard let text = text else { return false }
        return text.count >= 6
    }

    private func isEqual(_ text1: String?, _ text2: String?) -> Bool {
        guard let text1 = text1, let text2 = text2 else { return false }
        return text1 == text2
    }
}

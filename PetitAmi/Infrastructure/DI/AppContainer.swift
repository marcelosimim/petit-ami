//
//  AppContainer.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Swinject

class AppContainer {
    static let shared: Container = {
        let container = Container()

        container.register(FirebaseAuthRepository.self) { _ in DefaultFirebaseAuthRepository()}
        container.register(FirstView.self) { _ in DefaultFirstView()}
        container.register(RegisterView.self) { _ in DefaultRegisterView()}
        container.register(RegisterUseCase.self) { r in DefaultRegisterUseCase(firebaseAuthRepository: r.resolve(FirebaseAuthRepository.self)!)}
        container.register(RegisterViewModel.self) { r in DefaultRegisterViewModel(registerUseCase: r.resolve(RegisterUseCase.self)!)}
        container.register(LoginView.self) { _ in DefaultLoginView()}
        container.register(LoginUseCase.self) { r in DefaultLoginUseCase(firebaseAuthRepository: r.resolve(FirebaseAuthRepository.self)!)}
        container.register(LoginViewModel.self) { r in DefaultLoginViewModel(loginUseCase: r.resolve(LoginUseCase.self)!)}
        return container
    }()
}

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
        container.register(FirestoreRepository.self) { _ in DefaultFirestoreRepository()}
        container.register(StorageRepository.self) { _ in DefaultStorageRepository()}

        container.register(FirstView.self) { _ in DefaultFirstView()}
        container.register(RegisterView.self) { _ in DefaultRegisterView()}
        container.register(LoginView.self) { _ in DefaultLoginView()}
        container.register(HomeView.self) { _ in DefaultHomeView()}
        container.register(LibraryView.self) { _ in DefaultLibraryView()}
        container.register(ExerciseView.self) { _ in DefaultExerciseView()}

        container.register(RegisterUseCase.self) { r in DefaultRegisterUseCase(firebaseAuthRepository: r.resolve(FirebaseAuthRepository.self)!)}
        container.register(LoginUseCase.self) { r in DefaultLoginUseCase(firebaseAuthRepository: r.resolve(FirebaseAuthRepository.self)!)}
        container.register(UserUseCase.self) { r in DefaultUserUseCase(firestoreRepository: r.resolve(FirestoreRepository.self)!, storageRepository: r.resolve(StorageRepository.self)!)}
        container.register(UnitUseCase.self) { r in DefaultUnitUseCase(firestoreRepository: r.resolve(FirestoreRepository.self)!, storageRepository: r.resolve(StorageRepository.self)!)}

        container.register(RegisterViewModel.self) { r in DefaultRegisterViewModel(registerUseCase: r.resolve(RegisterUseCase.self)!)}
        container.register(LoginViewModel.self) { r in DefaultLoginViewModel(loginUseCase: r.resolve(LoginUseCase.self)!)}
        container.register(HomeViewModel.self) { r in DefaultHomeViewModel(userUseCase: r.resolve(UserUseCase.self)!, unitUseCase: r.resolve(UnitUseCase.self)!)}
        container.register(LibraryViewModel.self) { r in DefaultLibraryViewModel(unitUseCase: r.resolve(UnitUseCase.self)!)}
        container.register(ExerciseViewModel.self) { r in DefaultExerciseViewModel(exerciseUseCase: r.resolve(ExerciseUseCase.self)!)}

        return container
    }()
}

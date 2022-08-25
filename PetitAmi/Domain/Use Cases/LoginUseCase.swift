//
//  LoginUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Foundation

protocol LoginUseCase {
    func login(email:String, password: String, completion: @escaping(Error?) -> Void)
    func logout(completion: @escaping(Error?) -> Void)
}

class DefaultLoginUseCase: LoginUseCase {
    private let firebaseAuthRepository: FirebaseAuthRepository

    init(firebaseAuthRepository: FirebaseAuthRepository){
        self.firebaseAuthRepository = firebaseAuthRepository
    }

    func login(email:String, password: String, completion: @escaping(Error?) -> Void) {
        firebaseAuthRepository.login(email: email, password: password, completion: completion)
    }

    func logout(completion: @escaping (Error?) -> Void) {
        firebaseAuthRepository.logout(completion: completion)
    }
}

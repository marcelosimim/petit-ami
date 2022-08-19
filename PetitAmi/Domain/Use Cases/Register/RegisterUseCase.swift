//
//  RegisterUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Foundation

protocol RegisterUseCase {
    func register(user:UserModel, email:String, password: String, completion: @escaping(Error?) -> Void)
}

class DefaultRegisterUseCase: RegisterUseCase {
    private let firebaseAuthRepository: FirebaseAuthRepository

    init(firebaseAuthRepository: FirebaseAuthRepository){
        self.firebaseAuthRepository = firebaseAuthRepository
    }

    func register(user: UserModel, email: String, password: String, completion: @escaping (Error?) -> Void) {
        firebaseAuthRepository.register(user: user, email: email,
                                        password: password, completion: completion)
    }
}

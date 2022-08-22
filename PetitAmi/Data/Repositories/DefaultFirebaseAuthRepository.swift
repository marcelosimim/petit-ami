//
//  DefaultFirebaseAuthRepository.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import FirebaseAuth
import Foundation

class DefaultFirebaseAuthRepository: FirebaseAuthRepository {

    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            completion(error)
        }
    }

    func register(user: UserModel, email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            guard let _ = authDataResult else {
                completion(error)
                return
            }
            self.addNewUserToCollection(user: UserEntity.fromModel(model: user), completion: completion)
        }
    }

    private func addNewUserToCollection(user: UserEntity, completion: @escaping (Error?) -> Void) {
        FirebaseReferences.userReference
            .setData([
            "name": user.name,
            "unit": user.unit,
            "exercise": user.exercise
        ]){
            error in
            completion(error)
        }
    }
}

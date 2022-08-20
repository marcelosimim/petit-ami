//
//  DefaultFirestoreRepository.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class DefaultFirestoreRepository: FirestoreRepository {

    func getUserInfo(completion: @escaping ((Result<UserModel, Error>) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var user = UserEntity()

        FirebaseCollections.userReference.document(uid).getDocument { document, error in
            guard let document = document?.data() else {
                completion(.failure(error!))
                return
            }

            user.name = document["name"] as? String
            user.unit = document["unit"] as? Int
            user.exercise = document["exercise"] as? Int
            user.frenchLevel = self.frenchLevel(unit: user.unit)

            completion(.success(user.toModel()))
        }
    }

    private func frenchLevel(unit: Int?) -> String {
        guard let unit = unit else { return "" }

        if unit <= 36 { return "Básico" }
        else if unit <= 71 { return "Intermediário" }
        else { return "Avançado" }
    }
}

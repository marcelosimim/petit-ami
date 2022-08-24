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
        guard let _ = Auth.auth().currentUser?.uid else { return }
        var user = UserEntity()

        FirebaseReferences.userReference
            .getDocument { document, error in
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

    func fetchExerciseAnswer(unit: Int, exercise: Int, completion: @escaping (Result<String, Error>) -> Void) {
        FirebaseReferences.exerciseReference(unit: unit, exercise: exercise)
            .getDocument { document, error in
                guard let document = document else {
                    completion(.failure(error!))
                    return
                }

                let answer = document.data()!["check"] as! String
                completion(.success(answer))
            }
    }

    func updateExercise(unit: Int, exercise: Int, completion: @escaping (UserModel?) -> Void) {
        fetchUnitSize(unit: unit) { unitSize in
            guard let unitSize = unitSize else {
                completion(nil)
                return
            }

            if self.isLastExercise(unitSize: unitSize, currentExercise: exercise) {
                let newUnit = unit+1
                FirebaseReferences.userReference.updateData([
                    "unit": newUnit,
                    "exercise": 1
                ])
                let userEntity = UserEntity(name: nil, unit: newUnit, exercise: 1, frenchLevel: nil, photo: nil)
                completion(userEntity.toModel())
            } else {
                let newExercise = exercise + 1
                FirebaseReferences.userReference.updateData([
                    "exercise": newExercise
                ])
                let userEntity = UserEntity(name: nil, unit: unit, exercise: newExercise, frenchLevel: nil, photo: nil)
                completion(userEntity.toModel())
            }
        }
    }

    private func fetchUnitSize(unit: Int, completion: @escaping (Int?) -> Void) {
        FirebaseReferences.unitReference(unit: unit)
            .getDocument { document, error in
            guard let document = document else {
                completion(nil)
                return
            }

            let unitSize = document.data()!["size"] as! Int
            completion(unitSize)
        }
    }

    private func isLastExercise(unitSize: Int, currentExercise: Int) -> Bool {
        (currentExercise + 1) <= unitSize ? false : true
    }
}

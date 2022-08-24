//
//  FirestoreRepository.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Foundation

protocol FirestoreRepository {
    func getUserInfo(completion: @escaping((Result<UserModel, Error>) -> Void))
    func fetchExerciseAnswer(unit: Int, exercise: Int, completion: @escaping (Result<String, Error>) -> Void)
    func updateExercise(unit: Int, exercise: Int, completion: @escaping (UserEntity?) -> Void)
}

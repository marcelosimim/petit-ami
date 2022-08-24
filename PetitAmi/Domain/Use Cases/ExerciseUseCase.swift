//
//  ExerciseUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/24/22.
//

import Foundation

protocol ExerciseUseCase {
    func fetchExerciseAnswer(unit: Int, exercise: Int, completion: @escaping (Result<String, Error>) -> Void)
    func fetchExerciseImage(unit: Int, exercise: Int, completion: @escaping (Result<Data, Error>) -> Void)
    func fetchExerciseSound(unit: Int, exercise: Int, completion: @escaping (Result<URL, Error>) -> Void)
    func updateExercise(unit: Int, exercise: Int, completion: @escaping (UserEntity?) -> Void)
}

class DefaultExerciseUseCase: ExerciseUseCase {
    private let firestoreRepository: FirestoreRepository
    private let storageRepository: StorageRepository

    init(firestoreRepository: FirestoreRepository, storageRepository: StorageRepository) {
        self.firestoreRepository = firestoreRepository
        self.storageRepository = storageRepository
    }

    func fetchExerciseAnswer(unit: Int, exercise: Int, completion: @escaping (Result<String, Error>) -> Void) {
        firestoreRepository.fetchExerciseAnswer(unit: unit, exercise: exercise, completion: completion)
    }

    func fetchExerciseImage(unit: Int, exercise: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        storageRepository.fetchExerciseImage(unit: unit, exercise: exercise, completion: completion)
    }

    func fetchExerciseSound(unit: Int, exercise: Int, completion: @escaping (Result<URL, Error>) -> Void) {
        storageRepository.fetchExerciseSound(unit: unit, exercise: exercise, completion: completion)
    }

    func updateExercise(unit: Int, exercise: Int, completion: @escaping (UserEntity?) -> Void) {
        firestoreRepository.updateExercise(unit: unit, exercise: exercise, completion: completion)
    }
}

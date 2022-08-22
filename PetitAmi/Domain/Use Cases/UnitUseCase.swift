//
//  UnitUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/22/22.
//

import Foundation

protocol UnitUseCase {
    func fetchUnitCover(unit: Int, completion: @escaping (Result<Data, Error>) -> Void)
    func getLibrary(completion: @escaping (Result<[Data], Error>) -> Void)
}

class DefaultUnitUseCase: UnitUseCase {

    private let firestoreRepository: FirestoreRepository
    private let storageRepository: StorageRepository

    init(firestoreRepository: FirestoreRepository, storageRepository: StorageRepository) {
        self.firestoreRepository = firestoreRepository
        self.storageRepository = storageRepository
    }

    func fetchUnitCover(unit: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        storageRepository.fetchUnitCover(unit: unit, completion: completion)
    }

    func getLibrary(completion: @escaping (Result<[Data], Error>) -> Void) {
        storageRepository.getLibrary(completion: completion)
    }
}

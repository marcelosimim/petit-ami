//
//  UserUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/22/22.
//

import Foundation

protocol UserUseCase {
    func getUserInfo(completion: @escaping((Result<UserModel, Error>) -> Void))
    func downloadUserPhoto(completion: @escaping ((Result<Data, Error>) -> Void))
    func uploadUserPhoto(image: Data, completion: @escaping ((Error?) -> Void))
}

class DefaultUserUseCase: UserUseCase {

    private let firestoreRepository: FirestoreRepository
    private let storageRepository: StorageRepository

    init(firestoreRepository: FirestoreRepository, storageRepository: StorageRepository) {
        self.firestoreRepository = firestoreRepository
        self.storageRepository = storageRepository
    }

    func getUserInfo(completion: @escaping ((Result<UserModel, Error>) -> Void)) {
        firestoreRepository.getUserInfo(completion: completion)
    }

    func downloadUserPhoto(completion: @escaping ((Result<Data, Error>) -> Void)) {
        storageRepository.downloadUserPhoto(completion: completion)
    }

    func uploadUserPhoto(image: Data, completion: @escaping ((Error?) -> Void)) {
        storageRepository.uploadUserPhoto(image: image, completion: completion)
    }
}

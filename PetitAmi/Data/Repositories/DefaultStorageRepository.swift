//
//  DefaultStorageRepository.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/20/22.
//

import Foundation

class DefaultStorageRepository: StorageRepository {
    func downloadUserPhoto(completion: @escaping ((Result<Data, Error>) -> Void)) {
        FirebaseReferences.storageReference
            .getData(maxSize: 4 * 1024 * 1024) { data, error in
                guard let data = data else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(data))
            }
    }

    func uploadUserPhoto(image: Data, completion: @escaping ((Error?) -> Void)) {
        FirebaseReferences.storageReference
            .putData(image, metadata: nil) { _ , error in
                    completion(error)
            }
    }

    func fetchUnitCover(unit: Int, completion: @escaping (Result<Data, Error>) -> Void) {

    }
}

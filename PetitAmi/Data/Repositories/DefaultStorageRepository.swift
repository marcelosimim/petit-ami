//
//  DefaultStorageRepository.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/20/22.
//

import Foundation

class DefaultStorageRepository: StorageRepository {

    func downloadUserPhoto(completion: @escaping ((Result<Data, Error>) -> Void)) {
        FirebaseReferences.storageUserReference
            .getData(maxSize: 4 * 1024 * 1024) { data, error in
                guard let data = data else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(data))
            }
    }

    func uploadUserPhoto(image: Data, completion: @escaping ((Error?) -> Void)) {
        FirebaseReferences.storageUserReference
            .putData(image, metadata: nil) { _ , error in
                    completion(error)
            }
    }

    func fetchUnitCover(unit: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        FirebaseReferences.storageUnitReference(number: unit)
            .getData(maxSize: 4 * 1024 * 1024) { data, error in
                guard let data = data else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(data))
            }
    }

    func getLibrary(completion: @escaping (Result<[Data], Error>) -> Void) {
        let numberOfUnits = 18
        var units: [Data] = Array<Data>.init(repeating: Data(), count: numberOfUnits)

        for index in 0...(numberOfUnits-1) {
            fetchUnitCover(unit: index+1) { result in
                switch result {
                    case .success(let data):
                        units[index] = data
                        completion(.success(units))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
    }

    func getPdf(unit: Int, completion: @escaping (Result<URL, Error>) -> Void) {
        FirebaseReferences.storagePdfReference(number: unit)
            .downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
    }

    func fetchExerciseImage(unit: Int, exercise: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        FirebaseReferences.storageImageReference(unit: unit, exercise: exercise)
            .getData(maxSize: 4 * 1024 * 1024) { data, error in
                guard let data = data else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(data))
            }
    }

    func fetchExerciseSound(unit: Int, exercise: Int, completion: @escaping (Result<URL, Error>) -> Void) {
        FirebaseReferences.storageSoundReference(unit: unit, exercise: exercise)
            .downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
    }
}

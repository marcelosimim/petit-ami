//
//  StorageRepository.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/20/22.
//

import Foundation

protocol StorageRepository {
    func downloadUserPhoto(completion: @escaping((Result<Data, Error>) -> Void))
    func uploadUserPhoto(image: Data, completion: @escaping((Error?) -> Void))
    func fetchUnitCover(unit: Int, completion: @escaping(Result<Data, Error>) -> Void)
    func getLibrary(completion: @escaping(Result<[Data], Error>) -> Void)
    func getPdf(unit: Int, completion: @escaping(Result<URL, Error>) -> Void)
    func fetchExerciseImage(unit: Int, exercise: Int, completion: @escaping (Result<Data, Error>) -> Void)
    func fetchExerciseSound(unit: Int, exercise: Int, completion: @escaping (Result<URL, Error>) -> Void)
}

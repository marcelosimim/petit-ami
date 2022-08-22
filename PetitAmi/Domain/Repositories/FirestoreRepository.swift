//
//  FirestoreRepository.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Foundation

protocol FirestoreRepository {
    func getUserInfo(completion: @escaping((Result<UserModel, Error>) -> Void))
}

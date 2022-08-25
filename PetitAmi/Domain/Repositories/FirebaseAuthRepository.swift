//
//  FirebaseAuthRepository.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

protocol FirebaseAuthRepository {
    func login(email:String, password: String, completion: @escaping(Error?) -> Void)
    func register(user:UserModel, email:String, password: String, completion: @escaping(Error?) -> Void)
    func logout(completion: @escaping(Error?) -> Void)
}

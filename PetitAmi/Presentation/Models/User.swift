//
//  User.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Foundation

struct User {
    var name:String?
    var unit:Int?
    var exercise:Int?
    var frenchLevel:Double?
    var photo: Data?

    func toModel() -> UserModel {
        UserModel(name: name,
                  unit: unit,
                  exercise: exercise,
                  frenchLevel: frenchLevel,
                  photo: photo)
    }
}

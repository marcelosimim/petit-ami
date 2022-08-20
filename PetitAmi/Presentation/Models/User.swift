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
    var frenchLevel:String?
    var photo: Data?
    var progress: Float?

    func toModel() -> UserModel {
        UserModel(name: name,
                  unit: unit,
                  exercise: exercise,
                  frenchLevel: frenchLevel,
                  photo: photo)
    }

    static func fromModel(model: UserModel) -> User {
        User(name: model.name,
             unit: model.unit,
             exercise: model.exercise,
             frenchLevel: model.frenchLevel,
             photo: model.photo,
             progress: Float(model.unit ?? 0)/96.0)
    }
}

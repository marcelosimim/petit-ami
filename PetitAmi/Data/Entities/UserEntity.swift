//
//  UserEntity.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Foundation

struct UserEntity {
    var name:String?
    var unit:Int?
    var exercise:Int?
    var frenchLevel:Double?
    var photo: Data?

    static func fromModel(model: UserModel) -> UserEntity{
        UserEntity(name: model.name,
                   unit: model.unit,
                   exercise: model.exercise,
                   frenchLevel: model.frenchLevel,
                   photo: model.photo)
    }
}

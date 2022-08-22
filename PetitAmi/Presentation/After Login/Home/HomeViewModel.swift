//
//  HomeViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Foundation

protocol HomeViewModel {
    var user: Observable<User?> { get }
    var unit: Observable<Unit?> { get }
    func getUserInfo()
    func uploadPhoto(data: Data)
}

class DefaultHomeViewModel: HomeViewModel {

    private let userUseCase: UserUseCase
    private let unitUseCase: UnitUseCase
    var user = Observable<User?>(nil)
    var unit = Observable<Unit?>(nil)

    init(userUseCase: UserUseCase, unitUseCase: UnitUseCase) {
        self.userUseCase = userUseCase
        self.unitUseCase = unitUseCase
    }

    func getUserInfo() {
        userUseCase.getUserInfo { result in
            switch result {
            case .success(let userModel):
                self.user.value = User.fromModel(model: userModel)
                self.getCurrentExerciseInfo()
            case .failure(_):
                break
            }
        }
        userUseCase.downloadUserPhoto { result in
            switch result {
            case .success(let data):
                self.user.value?.photo = data
            case .failure(_):
                break
            }
        }
    }

    func uploadPhoto(data: Data) {
        userUseCase.uploadUserPhoto(image: data) { error in
            guard error != nil else {
                self.user.value?.photo = data
                return
            }
        }
    }

    private func getCurrentExerciseInfo() {
        getUnitCover()
    }

    private func getUnitCover() {
        guard let number = user.value?.unit else { return }
        var unit = Unit()
        unit.number = number

        unitUseCase.fetchUnitCover(unit: number) { result in
            switch result {
            case .success(let data):
                unit.image = data
                self.unit.value = unit
            case .failure(_):
                break
            }
        }
    }
}

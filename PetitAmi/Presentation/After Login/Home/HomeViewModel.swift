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

    private let homeUseCase: HomeUseCase
    var user = Observable<User?>(nil)
    var unit = Observable<Unit?>(nil)

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }

    func getUserInfo() {
        homeUseCase.getUserInfo { result in
            switch result {
            case .success(let userModel):
                self.user.value = User.fromModel(model: userModel)
                self.getCurrentExerciseInfo()
            case .failure(_):
                break
            }
        }
        homeUseCase.downloadUserPhoto { result in
            switch result {
            case .success(let data):
                self.user.value?.photo = data
            case .failure(_):
                break
            }
        }
    }

    func uploadPhoto(data: Data) {
        homeUseCase.uploadUserPhoto(image: data) { error in
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

        homeUseCase.fetchUnitCover(unit: number) { result in
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

//
//  HomeViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Foundation

protocol HomeViewModel {
    var user: Observable<User?> { get }
    func getUserInfo()
    func uploadPhoto(data: Data)
}

class DefaultHomeViewModel: HomeViewModel {

    private let homeUseCase: HomeUseCase
    var user = Observable<User?>(nil)

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }

    func getUserInfo() {
        homeUseCase.getUserInfo { result in
            switch result {
            case .success(let userModel):
                self.user.value = User.fromModel(model: userModel)
            case .failure(let error):
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
            guard let error = error else {
                self.user.value?.photo = data
                return
            }
        }
    }
}

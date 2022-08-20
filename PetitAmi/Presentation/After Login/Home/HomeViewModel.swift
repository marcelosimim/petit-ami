//
//  HomeViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

protocol HomeViewModel {
    var user: Observable<User?> { get }
    func getUserInfo()
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
    }
}

//
//  LibraryViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/22/22.
//

import Foundation

protocol LibraryViewModel {
    var unit: Observable<[Data]> { get }
    func getAll()
}

class DefaultLibraryViewModel: LibraryViewModel {
    var unit = Observable<[Data]>([])

    private let unitUseCase: UnitUseCase

    init(unitUseCase: UnitUseCase) {
        self.unitUseCase = unitUseCase
    }

    func getAll() {
        unitUseCase.getLibrary { result in
            switch result {
                case .success(let data):
                    self.unit.value = data
                case .failure(_):
                    break
            }
        }
    }
}

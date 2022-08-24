//
//  LibraryViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/22/22.
//

import Foundation

protocol LibraryViewModel {
    var unit: Observable<[Data]> { get }
    var pdf: Observable<URL?> { get }
    func getAll()
    func getPdf(unit: Int)
}

class DefaultLibraryViewModel: LibraryViewModel {
    var unit = Observable<[Data]>([])
    var pdf = Observable<URL?>(nil)
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

    func getPdf(unit: Int) {
        unitUseCase.getPdf(unit: unit) { result in
            switch result {
                case .success(let pdf):
                    self.pdf.value = pdf
                case .failure(_):
                    break
            }
        }
    }
}

//
//  PrimaryButton.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/18/22.
//

import UIKit

class PrimaryButton: UIButton {

    func setup(title: String) {
        setTitle(title, for: .normal)
        setupComponent()
    }

    private func setupComponent() {
        setupStyles()
        layer.cornerRadius = 8
    }
}


extension PrimaryButton: Stylable {
    func setupColors() {
        backgroundColor = .button
    }
}

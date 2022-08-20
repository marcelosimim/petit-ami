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
        backgroundColor = .darkBlue
    }
}

extension PrimaryButton {
    open override var isEnabled: Bool{
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}

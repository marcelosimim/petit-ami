//
//  Stylable.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/18/22.
//

import Foundation

public protocol Stylable {
    func setupColors()
    func setupImages()
    func setupFonts()
    func setupTexts()
}

public extension Stylable {
    func setupStyles() {
        setupColors()
        setupImages()
        setupFonts()
        setupTexts()
    }

    func setupColors() { }
    func setupImages() { }
    func setupFonts() { }
    func setupTexts() { }
}

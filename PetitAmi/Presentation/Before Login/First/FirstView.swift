//
//  FirstView.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/18/22.
//

import UIKit

protocol FirstView {
    var contentView: UIView { get }
    var signInButton: PrimaryButton { get }
    var signUpButton: PrimaryButton { get }
}

class DefaultFirstView: FirstView {
    var contentView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    var signInButton = PrimaryButton()
    var signUpButton = PrimaryButton()

    init() {
        setupStyles()
        addViews()
    }

    func addViews() {
        contentView.addSubviews([imageView, titleLabel, signInButton, signUpButton])

        imageView.topToTop(of: contentView, margin: .vertical224)
        imageView.centerHorizontal(to: contentView)

        titleLabel.topToBottom(of: imageView, margin: .vertical64)
        titleLabel.centerHorizontal(to: contentView)
        titleLabel.leadingToLeading(of: contentView, margin: .leadingMargin)

        signInButton.topToBottom(of: titleLabel, margin: .vertical128)
        signInButton.centerHorizontal(to: contentView)
        signInButton.leadingToLeading(of: contentView, margin: .leadingMargin)

        signUpButton.topToBottom(of: signInButton, margin: .vertical16)
        signUpButton.centerHorizontal(to: contentView)
        signUpButton.leadingToLeading(of: contentView, margin: .leadingMargin)
    }
}

extension DefaultFirstView: Stylable {
    func setupColors() {
        contentView.backgroundColor = .background
        titleLabel.textColor = .white
    }

    func setupImages() {
        imageView.image = .books
    }

    func setupFonts() {
        titleLabel.font = .systemFont(ofSize: 24)
    }

    func setupTexts() {
        titleLabel.text = "Bonjour, mon ami! Bienvenue sur votre app française."
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        signInButton.setup(title: "ENTRAR")
        signUpButton.setup(title: "CADASTRAR")
    }
}

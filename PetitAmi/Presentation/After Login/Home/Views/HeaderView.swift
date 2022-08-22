//
//  HeaderView.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import UIKit

class HeaderView: UIView {
    private let headerView = UIImageView()
    private let userPhoto = UIImageView()
    private lazy var labelsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [welcomeLabel, unitLabel, exerciseLabel, frenchLevel])
        stack.spacing = 2
        stack.setCustomSpacing(10, after: welcomeLabel)
        stack.axis = .vertical
        return stack
    }()
    private let welcomeLabel = UILabel()
    private let unitLabel = UILabel()
    private let exerciseLabel = UILabel()
    private let frenchLevel = UILabel()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupStyles()
        addViews()
    }

    func addViews() {
        addSubviews([headerView, userPhoto, labelsStack])

        headerView.topToTop(of: self)
        headerView.leadingToLeading(of: self)
        headerView.trailingToTrailing(of: self)
        headerView.heightTo(.headerHeight)

        userPhoto.centerVertical(to: headerView)
        userPhoto.leadingToLeading(of: self, margin: .leadingMargin)
        userPhoto.heightTo(100)
        userPhoto.widthTo(100)

        labelsStack.leadingToTrailing(of: userPhoto, margin: 8)
        labelsStack.centerVertical(to: userPhoto)
    }

    func setupLabels(user: User) {
        welcomeLabel.text = "Bienvenue, \(user.name ?? "")!"
        unitLabel.text = "Unidade atual: \(user.unit ?? 0)"
        exerciseLabel.text = "Exercício atual: \(user.exercise ?? 0)"
        frenchLevel.text = "Nível do francês: \(user.frenchLevel ?? "")"
    }

    func setupPhoto(data: Data?) {
        guard let data = data else { return }
        userPhoto.image = UIImage(data: data)
        configureUserPhoto()
    }
}

extension HeaderView: Stylable {
    func setupColors() {
        userPhoto.backgroundColor = .white
        welcomeLabel.textColor = .white
        unitLabel.textColor = .white
        exerciseLabel.textColor = .white
        frenchLevel.textColor = .white
    }

    func setupImages() {
        headerView.image = .header
        userPhoto.image = .logo
        configureUserPhoto()
    }

    func configureUserPhoto(){
        userPhoto.layer.borderWidth = 1
        userPhoto.layer.cornerRadius = 50
        userPhoto.clipsToBounds = true
        userPhoto.contentMode = .scaleAspectFill
    }

    func setupFonts() {
        welcomeLabel.font = .systemFont(ofSize: 16)
        unitLabel.font = .systemFont(ofSize: 12)
        exerciseLabel.font = .systemFont(ofSize: 12)
        frenchLevel.font = .systemFont(ofSize: 12)
    }
}

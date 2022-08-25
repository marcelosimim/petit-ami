//
//  ExerciseView.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/24/22.
//

import UIKit

protocol ExerciseView {
    var contentView: UIView { get }
    var speakerButton: UIButton { get }
    var recordButton: UIButton { get }
    var answerTextField: InputTextField { get }

    func setupImage(data: Data)
    func setupComponents(isEnabled: Bool)
}

class DefaultExerciseView: ExerciseView {
    var contentView = UIView()
    var speakerButton = UIButton()
    var recordButton = UIButton()
    var answerTextField = InputTextField()
    private let exerciseImage = UIImageView()
    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 128*Dimen.widthMultiplier
        stack.axis = .horizontal
        return stack
    }()
    private let activityIndicator : UIActivityIndicatorView  = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
     }()

    init() {
        setupStyles()
        addViews()
        setupComponents(isEnabled: false)
    }

    private func addViews() {
        speakerButton.heightTo(.vertical32)
        speakerButton.widthTo(.vertical32)
        recordButton.heightTo(.vertical32)
        recordButton.widthTo(.vertical32)
        buttonStack.addArrangedSubview(speakerButton)
        buttonStack.addArrangedSubview(recordButton)
        contentView.addSubviews([exerciseImage, buttonStack, answerTextField, activityIndicator])

        exerciseImage.topToTop(of: contentView, margin: .vertical128)
        exerciseImage.leadingToLeading(of: contentView, margin: .leadingMargin)
        exerciseImage.centerHorizontal(to: contentView)
        exerciseImage.heightTo(.vertical160)

        buttonStack.topToBottom(of: exerciseImage, margin: .vertical64)
        buttonStack.centerHorizontal(to: contentView)
        buttonStack.heightTo(.vertical64)

        answerTextField.topToBottom(of: buttonStack, margin: .vertical32)
        answerTextField.centerHorizontal(to: contentView)
        answerTextField.leadingToLeading(of: contentView, margin: .leadingMargin)
        answerTextField.heightTo(.textFieldHeight)

        activityIndicator.centerVertical(to: exerciseImage)
        activityIndicator.centerHorizontal(to: contentView)
    }

    func setupImage(data: Data) {
        exerciseImage.image = UIImage(data: data)
        activityIndicator.stopAnimating()
    }

    func setupComponents(isEnabled: Bool) {
        speakerButton.isEnabled = isEnabled
        recordButton.isEnabled = isEnabled
        answerTextField.isEnabled = isEnabled
    }
}

extension DefaultExerciseView: Stylable {
    func setupColors() {
        contentView.backgroundColor = .background
        speakerButton.tintColor = .red
        recordButton.tintColor = .red
        activityIndicator.color = .white
    }

    func setupImages() {
        exerciseImage.contentMode = .scaleAspectFill
        speakerButton.setImage(.speaker, for: .normal)
        speakerButton.contentHorizontalAlignment = .fill
        speakerButton.contentVerticalAlignment = .fill
        speakerButton.imageView?.contentMode = .scaleAspectFit
        recordButton.setImage(.mic, for: .normal)
        recordButton.contentHorizontalAlignment = .fill
        recordButton.contentVerticalAlignment = .fill
        recordButton.imageView?.contentMode = .scaleAspectFit
    }

    func setupTexts() {
        answerTextField.setup(type: .answer)
    }
}

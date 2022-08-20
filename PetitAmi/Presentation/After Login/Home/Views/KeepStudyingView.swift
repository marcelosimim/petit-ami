//
//  KeepStudyingView.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/20/22.
//

import UIKit

class KeepStudyingView: UIView {

    private let progressLabel = UILabel()
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 5
        return progressView
    }()
    private let coverImage = UIImageView()
    private let keepStudyingLabel = UILabel()
    private let activityIndicator : UIActivityIndicatorView  = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
     }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupStyles()
        addViews()
        layer.cornerRadius = 20
    }

    func addViews() {
        addSubviews([progressLabel, progressView, activityIndicator, coverImage, keepStudyingLabel])

        progressLabel.topToTop(of: self, margin: .vertical8)
        progressLabel.leadingToLeading(of: self, margin: .leadingMargin)

        progressView.heightTo(.vertical8)
        progressView.topToBottom(of: progressLabel, margin: .vertical16)
        progressView.leadingToLeading(of: progressLabel)
        progressView.centerHorizontal(to: self)

        coverImage.topToBottom(of: progressView, margin: .vertical16)
        coverImage.centerHorizontal(to: self)
        coverImage.heightTo(150*Dimen.heightMultiplier)

        keepStudyingLabel.topToBottom(of: coverImage, margin: .vertical16)
        keepStudyingLabel.centerHorizontal(to: self)
        keepStudyingLabel.bottomToBottom(of: self, margin: .vertical16)

        activityIndicator.centerVertical(to: coverImage)
        activityIndicator.centerHorizontal(to: self)
    }

    func setProgress(progress: Float?) {
        progressView.setProgress(progress ?? 0, animated: true)
    }

    func setCoverImage(image: UIImage) {
        coverImage.image = image
        activityIndicator.stopAnimating()
    }
}

extension KeepStudyingView: Stylable {
    func setupColors() {
        backgroundColor = .darkBlue
        progressLabel.textColor = .white
        progressView.trackTintColor = .red
        progressView.progressTintColor = .background
        keepStudyingLabel.textColor = .white
        activityIndicator.color = .white
    }

    func setupImages() {
        coverImage.contentMode = .scaleAspectFit
        coverImage.isUserInteractionEnabled = true
    }

    func setupFonts() {
        progressLabel.font = .systemFont(ofSize: 16)
        keepStudyingLabel.font = .systemFont(ofSize: 16)
    }

    func setupTexts() {
        progressLabel.text = "Progresso"
        keepStudyingLabel.text = "Continue estudando"
    }
}


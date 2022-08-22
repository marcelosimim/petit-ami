//
//  HomeView.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import UIKit

protocol HomeView {
    var contentView: UIView { get }
    var headerView: HeaderView { get }
    var keepStudyingView: KeepStudyingView { get }
}

class DefaultHomeView: HomeView {
    var contentView = UIView()
    var headerView = HeaderView()
    var keepStudyingView = KeepStudyingView()

    init() {
        setupStyles()
        addViews()
    }

    private func addViews() {
        contentView.addSubviews([headerView, keepStudyingView])
        headerView.topToTop(of: contentView)
        headerView.leadingToLeading(of: contentView)
        headerView.trailingToTrailing(of: contentView)

        keepStudyingView.centerVertical(to: contentView)
        keepStudyingView.centerHorizontal(to: contentView)
        keepStudyingView.leadingToLeading(of: contentView, margin: .leadingMargin)
    }
}

extension DefaultHomeView: Stylable {
    func setupColors() {
        contentView.backgroundColor = .background
    }

    func setupTexts() {

    }
}

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
}

class DefaultHomeView: HomeView {
    var contentView = UIView()
    var headerView = HeaderView()

    init() {
        setupStyles()
        addViews()
    }

    func addViews() {
        contentView.addSubviews([headerView])
        headerView.topToTop(of: contentView)
        headerView.leadingToLeading(of: contentView)
        headerView.trailingToTrailing(of: contentView)
    }
}

extension DefaultHomeView: Stylable {
    func setupColors() {
        contentView.backgroundColor = .background
    }

    func setupTexts() {

    }
}

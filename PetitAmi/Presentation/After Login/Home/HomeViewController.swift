//
//  HomeViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import UIKit

class HomeViewController: UIViewController, Coordinating {
    var coodinator: Coordinator?
    private let homeView = AppContainer.shared.resolve(HomeView.self)!
    private let viewModel = AppContainer.shared.resolve(HomeViewModel.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView.contentView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserInfo()
        observerViewModel()
    }

    private func observerViewModel() {
        viewModel.user.bind { user in
            guard let user = user else { return }
            self.homeView.headerView.setupLabels(user: user)
            self.homeView.keepStudyingView.setProgress(progress: user.progress)
            self.homeView.headerView.setupPhoto(data: user.photo)
        }
    }
}

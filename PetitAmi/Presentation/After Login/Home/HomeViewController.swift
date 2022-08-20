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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view = homeView.contentView
    }
}

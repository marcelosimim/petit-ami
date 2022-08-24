//
//  TabBarViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import FirebaseAuth
import UIKit

class TabBarViewController: UITabBarController, Coordinating {
    var coodinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar()
        setupColors()
    }

    private func setupTabBar() {
        let home = HomeViewController()
        home.title = "Home"
        let library = LibraryViewController()
        library.title = "Biblioteca"

        setViewControllers([home, library], animated: false)
        modalPresentationStyle = .fullScreen

        setupImages()
    }

    private func setupImages() {
        guard let items = tabBar.items else { return }

        items[0].image = .house
        items[1].image = .library
    }

    private func setupColors() {
        tabBar.backgroundColor = .darkBlue
        tabBar.tintColor = .white
    }
}

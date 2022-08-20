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
        view.backgroundColor = .background
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar()
        setupColors()
    }

    private func setupTabBar() {
       let home = HomeViewController()
       home.title = "Home"

       setViewControllers([home], animated: false)
       modalPresentationStyle = .fullScreen

       setupImages()
    }

    private func setupImages() {
        guard let items = tabBar.items else { return }

        items[0].image = .house
    }

    private func setupColors() {
        tabBar.backgroundColor = .tabbar
        tabBar.tintColor = .white
    }
}

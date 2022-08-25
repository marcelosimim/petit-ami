//
//  HomeViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import UIKit

class HomeViewController: UIViewController {
    private let homeView = AppContainer.shared.resolve(HomeView.self)!
    private let viewModel = AppContainer.shared.resolve(HomeViewModel.self)!
    private let imagePickerController = UIImagePickerController()
    private let cameraPickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView.contentView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserInfo()
        observerViewModel()
        setupButtons()
        configurePickers()
    }

    private func observerViewModel() {
        viewModel.user.bind { user in
            guard let user = user else { return }
            self.homeView.headerView.setupLabels(user: user)
            self.homeView.keepStudyingView.setProgress(progress: user.progress)
            self.homeView.headerView.setupPhoto(data: user.photo)
        }

        viewModel.unit.bind { unit in
            guard let image = unit?.image else { return }
            self.homeView.keepStudyingView.setCoverImage(data: image)
        }
    }

    private func setupButtons() {
        homeView.headerView.userPhoto.isUserInteractionEnabled = true
        homeView.headerView.userPhoto.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapPhoto)))
        homeView.keepStudyingView.coverImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCover)))
        homeView.headerView.logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchDown)
    }

    @objc private func didTapCover() {
        let vc = ExerciseViewController()
        vc.unit = viewModel.user.value?.unit
        vc.exercise = viewModel.user.value?.exercise
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func didTapLogout() {
        Alert.alertToConfirm(title: "Logout", message: "Tem certeza que deseja sair?", controller: self) {
            self.viewModel.logout {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(FirstViewController(), animated: true)
                }
            }
        }
    }
}

extension HomeViewController: UIImagePickerControllerDelegate,   UINavigationControllerDelegate {
    func configurePickers() {
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        cameraPickerController.allowsEditing = true
        cameraPickerController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraPickerController.sourceType = .camera
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage, let data = image.pngData() else { return }
            viewModel.uploadPhoto(data: data)
            dismiss(animated: true)
    }

    @objc private func didTapPhoto() {
        let actionSheet = UIAlertController(title: "Escolha a fonte", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Câmera", style: .default, handler: { _ in
            self.present(self.cameraPickerController, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Biblioteca", style: .default, handler: { _ in
            self.present(self.imagePickerController, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(actionSheet, animated: true)
    }
}

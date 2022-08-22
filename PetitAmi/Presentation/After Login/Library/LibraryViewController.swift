//
//  LibraryViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/22/22.
//

import UIKit

class LibraryViewController: UIViewController {

    private let libraryView = AppContainer.shared.resolve(LibraryView.self)!
    private let viewModel = AppContainer.shared.resolve(LibraryViewModel.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        view = libraryView.contentView
        viewModel.getAll()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        libraryView.collectionView.delegate = self
        libraryView.collectionView.dataSource = self
        observerViewModel()
    }

    private func observerViewModel() {
        viewModel.unit.bind { unit in
            DispatchQueue.main.async {
                self.libraryView.collectionView.reloadData()
            }
        }
    }
}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.unit.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.identifier, for: indexPath) as? LibraryCollectionViewCell else {
            fatalError()
        }
        let data = viewModel.unit.value[indexPath.row]
        cell.setupImage(data: data)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Dimen.cellWidth, height: Dimen.cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

}

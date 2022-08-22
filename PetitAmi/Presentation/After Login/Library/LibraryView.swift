//
//  LibraryView.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/22/22.
//

import UIKit

protocol LibraryView {
    var contentView: UIView { get }
    var collectionView: UICollectionView { get }
}

class DefaultLibraryView: LibraryView {
    var contentView = UIView()
    var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(LibraryCollectionViewCell.self, forCellWithReuseIdentifier: LibraryCollectionViewCell.identifier)
        return collectionView
    }()

    init() {
        setupStyles()
        addViews()
    }

    private func addViews() {
        contentView.addSubviews([collectionView])

        collectionView.topToTop(of: contentView, margin: .vertical64)
        collectionView.leadingToLeading(of: contentView)
        collectionView.trailingToTrailing(of: contentView)
        collectionView.bottomToBottom(of: contentView, margin: .vertical64)
    }
}

extension DefaultLibraryView: Stylable {
    func setupColors() {
        contentView.backgroundColor = .background
    }

    func setupTexts() {

    }
}

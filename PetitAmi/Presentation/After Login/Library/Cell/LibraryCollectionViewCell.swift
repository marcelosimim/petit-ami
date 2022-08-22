//
//  LibraryCollectionViewCell.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/22/22.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    static let identifier = "\(LibraryCollectionViewCell.self)"

    private let imageView = UIImageView()

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 8
        addViews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    private func addViews() {
        contentView.addSubviews([imageView])

        imageView.topToTop(of: self)
        imageView.leadingToLeading(of: self)
        imageView.centerHorizontal(to: self)
        imageView.bottomToBottom(of: self)
        imageView.heightTo(150*Dimen.heightMultiplier)
    }

    func setupImage(data: Data?) {
        guard let data = data else { return }
        imageView.image = UIImage(data: data)
    }

    func setupImage(image: UIImage) {
        imageView.image = image
    }
}

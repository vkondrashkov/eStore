//
//  CartTableViewCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class CartTableViewCell: UITableViewCell {
    static var reuseIdentifier = "CartTableViewCellReuseIdentifier"

    private var productImageView: UIImageView!
    private var productPriceLabel: UILabel!
    private var productTitleLabel: UILabel!

    private let thumbnailSize: CGFloat = 100

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        setupProductImageView()
        setupProductPriceLabel()
        setupProductTitleLabel()
    }

    private func setupProductImageView() {
        productImageView = UIImageView()
        contentView.addSubview(productImageView)
        activateProductImageViewConstraints(view: productImageView)
    }

    private func setupProductPriceLabel() {
        productPriceLabel = UILabel()
        productPriceLabel.font = .boldSystemFont(ofSize: 17)
        productPriceLabel.textAlignment = .right
        contentView.addSubview(productPriceLabel)
        activateProductPriceLabelConstraints(view: productPriceLabel, anchorView: productImageView)
    }

    private func setupProductTitleLabel() {
        productTitleLabel = UILabel()
        productTitleLabel.font = .boldSystemFont(ofSize: 17)
        productTitleLabel.numberOfLines = 0
        contentView.addSubview(productTitleLabel)
        activateProductTitleLabelConstraints(view: productTitleLabel, anchorView: productImageView)
    }

    func display(imageUrl: String?, title: String, price: String) {
        if let url = imageUrl {
            productImageView.downloaded(from: url)
        } else {
            productImageView.image = UIImage(named: "image-not-found")
        }
        productTitleLabel.text = title
        productPriceLabel.text = price
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ThemeSupportable implementation
extension CartTableViewCell: ThemeSupportable {
    func apply(theme: Theme, animated: Bool) {
        contentView.backgroundColor = theme.foregroundColor
        productPriceLabel.textColor = theme.textColor
        productTitleLabel.textColor = theme.textColor
    }
}

// MARK: - Constraints
private extension CartTableViewCell {
    func activateProductImageViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: thumbnailSize),
            view.heightAnchor.constraint(equalToConstant: thumbnailSize),
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -10)
            ])
    }

    func activateProductPriceLabelConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -10)
            ])
    }

    func activateProductTitleLabelConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.topAnchor),
            view.leadingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10)
            ])
    }
}

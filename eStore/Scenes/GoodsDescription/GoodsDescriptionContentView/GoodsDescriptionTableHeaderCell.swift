//
//  GoodsDescriptionTableHeaderCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/15/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class GoodsDescriptionTableHeaderCell: UITableViewCell {
    static var reuseIdentifier = "GoodsDescriptionTableHeaderCellReuseIdentifier"

    private var containerView: UIView!
    private var productTitleLabel: UILabel!
    private var productImageView: UIImageView!

    private let imageSize: CGFloat = 300
    private let customTintColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white

        setupContainerView()
        setupProductImageView()
        setupProductTitleLabel()
    }

    private func setupContainerView() {
        containerView = UIView()
        contentView.addSubview(containerView)
        activateContainerViewConstraints(view: containerView)
    }

    private func setupProductImageView() {
        productImageView = UIImageView()
        containerView.addSubview(productImageView)
        activateProductImageViewConstraints(view: productImageView)
    }

    private func setupProductTitleLabel() {
        productTitleLabel = UILabel()
        productTitleLabel.font = .boldSystemFont(ofSize: 22)
        productTitleLabel.numberOfLines = 0
        productTitleLabel.textAlignment = .center
        containerView.addSubview(productTitleLabel)
        activateProductTitleLabelConstraints(view: productTitleLabel, anchorView: productImageView)
    }

    func display(title: String, imageUrl: String?) {
        if let url = imageUrl {
            // TODO: Download images from url
        } else {
            productImageView.image = UIImage(named: "image-not-found")
        }
        productTitleLabel.text = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints
private extension GoodsDescriptionTableHeaderCell {
    func activateContainerViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
    }

    func activateProductImageViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: imageSize),
            view.heightAnchor.constraint(equalToConstant: imageSize),
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10),
            view.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            view.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(lessThanOrEqualTo: superview.leadingAnchor, constant: -10)
            ])
    }

    func activateProductTitleLabelConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -10)
            ])
    }
}

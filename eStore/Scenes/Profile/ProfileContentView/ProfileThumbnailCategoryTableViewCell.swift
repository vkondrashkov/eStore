//
//  ProfileThumbnailCategoryTableViewCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileThumbnailCategoryTableViewCell: UITableViewCell {
    static var reuseIdentifier = "ProfileThumbnailCategoryTableViewCellReuseIdentifier"

    private var containerView: UIView!
    private var thumbnailImageView: UIImageView!
    private var titleLabel: UILabel!

    private let thumbnailImageSize: CGFloat = 64
    private let customTintColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white

        setupContainerView()
        setupThumbnailImageView()
        setupTitleLabel()
    }

    private func setupContainerView() {
        containerView = UIView()
        contentView.addSubview(containerView)
        activateContainerViewConstraints(view: containerView)
    }

    private func setupThumbnailImageView() {
        thumbnailImageView = UIImageView()
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.contentMode = .center
        thumbnailImageView.layer.cornerRadius = thumbnailImageSize / 2
        thumbnailImageView.layer.borderWidth = 1.0
        thumbnailImageView.layer.borderColor = UIColor(white: 0.0, alpha: 0.15).cgColor
        containerView.addSubview(thumbnailImageView)
        activateThumbnailImageViewConstraints(view: thumbnailImageView)
    }

    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20)
        containerView.addSubview(titleLabel)
        activateTitleLabelConstraints(view: titleLabel, anchorView: thumbnailImageView)
    }

    func display(thumbnailImageUrl: String?, title: String) {
        if let url = thumbnailImageUrl {
            thumbnailImageView.downloaded(from: url) // Temp
        } else {
            thumbnailImageView.image = UIImage(named: "default-user-icon")
        }
        titleLabel.text = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints
private extension ProfileThumbnailCategoryTableViewCell {
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

    func activateThumbnailImageViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: thumbnailImageSize),
            view.heightAnchor.constraint(equalToConstant: thumbnailImageSize),
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -10)
            ])
    }

    func activateTitleLabelConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: anchorView.centerYAnchor),
            view.leadingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10)
            ])
    }
}

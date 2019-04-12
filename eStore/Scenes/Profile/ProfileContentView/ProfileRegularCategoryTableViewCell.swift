//
//  ProfileRegularCategoryTableViewCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileRegularCategoryTableViewCell: UITableViewCell {
    static var reuseIdentifier = "ProfileRegularCategoryTableViewCellReuseIdentifier"

    private var containerView: UIView!
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!

    private let iconImageSize: CGFloat = 32

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        setupContainerView()
        setupIconImageView()
        setupTitleLabel()
    }

    private func setupContainerView() {
        containerView = UIView()
        contentView.addSubview(containerView)
        activateContainerViewConstraints(view: containerView)
    }

    private func setupIconImageView() {
        iconImageView = UIImageView()
        containerView.addSubview(iconImageView)
        activateIconImageViewConstraints(view: iconImageView)
    }

    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 17)
        containerView.addSubview(titleLabel)
        activateTitleLabelConstraints(view: titleLabel, anchorView: iconImageView)
    }

    func display(iconImageUrl: String?, title: String) {
        if let url = iconImageUrl, let icon = UIImage(named: url) {
            iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
        } else {
            iconImageView.image = UIImage(named: "error-icon")!.withRenderingMode(.alwaysTemplate)
        }
        titleLabel.text = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ThemeSupportable implementation
extension ProfileRegularCategoryTableViewCell: ThemeSupportable {
    func apply(theme: Theme) {
        contentView.backgroundColor = theme.foregroundColor
        titleLabel.textColor = theme.textColor
        iconImageView.tintColor = theme.tintColor
    }
}

// MARK: - Constraints
private extension ProfileRegularCategoryTableViewCell {
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

    func activateIconImageViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: iconImageSize),
            view.heightAnchor.constraint(equalToConstant: iconImageSize),
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

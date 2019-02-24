//
//  CategoryTableViewCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    static var reuseIdentifier: String {
        return "CategoryTableViewCellReuseIdentifier"
    }

    private var iconImageView: UIImageView!
    private var descriptionLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .white
        setupIconImageView()
        setupDescriptionLabel()
    }

    private func setupIconImageView() {
        iconImageView = UIImageView()
        contentView.addSubview(iconImageView)
        activateIconImageViewConstraints(view: iconImageView)
    }

    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.font = .boldSystemFont(ofSize: 17)
        descriptionLabel.textColor = .black
        contentView.addSubview(descriptionLabel)
        activateDescriptionLabelConstraints(view: descriptionLabel, anchorView: iconImageView)
    }

    func display(icon: UIImage?, description: String) {
        descriptionLabel.text = description
        if let categoryIcon = icon {
            iconImageView.image = categoryIcon
        } else {
            iconImageView.image = UIImage(named: "error-icon")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints
private extension CategoryTableViewCell {
    func activateIconImageViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -10),
            view.widthAnchor.constraint(equalTo: view.heightAnchor)
            ])
    }

    func activateDescriptionLabelConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -10)
            ])
    }
}

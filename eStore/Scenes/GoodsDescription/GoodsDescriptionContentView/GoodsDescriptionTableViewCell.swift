//
//  GoodsDescriptionTableViewCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class GoodsDescriptionTableViewCell: UITableViewCell {
    static var reuseIdentifier: String {
        return "GoodsDescriptionTableViewCellReuseIdentifier"
    }

    private var containerView: UIView!
    private var propertyNameLabel: UILabel!
    private var propertyValueLabel: UILabel!

    private let customTintColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white

        setupContainerView()
        setupPropertyNameLabel()
        setupPropertyValueLabel()
    }

    private func setupContainerView() {
        containerView = UIView()
        contentView.addSubview(containerView)
        activateContainerViewConstraints(view: containerView)
    }

    private func setupPropertyNameLabel() {
        propertyNameLabel = UILabel()
        propertyNameLabel.font = .boldSystemFont(ofSize: 17)
        containerView.addSubview(propertyNameLabel)
        activatePropertyNameLabelConstraints(view: propertyNameLabel)
    }

    private func setupPropertyValueLabel() {
        propertyValueLabel = UILabel()
        propertyValueLabel.font = .systemFont(ofSize: 17)
        containerView.addSubview(propertyNameLabel)
        activatePropertyValueLabelConstraints(view: propertyValueLabel, anchorView: propertyNameLabel)
    }

    func display(name: String, value: String) {
        propertyNameLabel.text = name
        propertyValueLabel.text = value
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints
private extension GoodsDescriptionTableViewCell {
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

    func activatePropertyNameLabelConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 20),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -20),
            view.trailingAnchor.constraint(equalTo: superview.centerXAnchor, constant: -10)
            ])
    }

    func activatePropertyValueLabelConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 20),
            view.leadingAnchor.constraint(equalTo: superview.centerXAnchor, constant: 10),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -20),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10)
            ])
    }
}

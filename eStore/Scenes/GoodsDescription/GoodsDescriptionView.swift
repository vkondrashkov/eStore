//
//  GoodsDescriptionView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class GoodsDescriptionViewImpl: UIViewController {
    var presenter: GoodsDescriptionPresenter!
    var dataSource: GoodsDescriptionTableViewDataSource!

    private var scrollView: UIScrollView!
    private var productImageView: UIImageView!
    private var productNameLabel: UILabel!
    private var descriptionTableView: UITableView!

    private let productImageSize: CGFloat = 300

    private let goodsDescriptionBackgroundColor = UIColor(red: 242.0 / 255.0, green: 241.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    private let customTintColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)

    override func loadView() {
        super.loadView()
        view.backgroundColor = goodsDescriptionBackgroundColor
        navigationController?.navigationBar.tintColor = customTintColor

        setupScrollView()
        setupProductImageView()
        setupProductNameLabel()
        setupDescriptionTableView()
    }

    private func setupScrollView() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        activateScrollViewConstraints(view: scrollView)
    }

    private func setupProductImageView() {
        productImageView = UIImageView()
        productImageView.image = UIImage(named: "image-not-found") // Temp
        scrollView.addSubview(productImageView)
        activateProductImageViewConstraints(view: productImageView)
    }

    private func setupProductNameLabel() {
        productNameLabel = UILabel()
        productNameLabel.font = .boldSystemFont(ofSize: 24)
        productNameLabel.textAlignment = .center
        productNameLabel.textColor = customTintColor
        productNameLabel.text = "ProductTest" // Temp
        scrollView.addSubview(productNameLabel)
        activateProductNameLabelConstraints(view: productNameLabel, anchorView: productImageView)
    }

    private func setupDescriptionTableView() {
        descriptionTableView = UITableView()
        descriptionTableView.tableFooterView = UIView()
        descriptionTableView.backgroundColor = .clear
        descriptionTableView.register(GoodsDescriptionTableViewCell.self, forCellReuseIdentifier: GoodsDescriptionTableViewCell.reuseIdentifier)
        descriptionTableView.dataSource = dataSource
        descriptionTableView.delegate = self
        scrollView.addSubview(descriptionTableView)
        activateGoodsDescriptionTableViewConstraints(view: descriptionTableView, anchorView: productNameLabel)
    }
}

// MARK: - GoodsDescriptionView implementation
extension GoodsDescriptionViewImpl: GoodsDescriptionView { }

// MARK: - GoodsDescriptionShow implementation
extension GoodsDescriptionViewImpl: GoodsDescriptionShow {
    var rootViewController: UIViewController {
        return self
    }
}

// MARK: - UITableViewDelegate implementation
extension GoodsDescriptionViewImpl: UITableViewDelegate { }

// MARK: - Constraints
private extension GoodsDescriptionViewImpl {
    func activateScrollViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

    func activateProductImageViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: productImageSize),
            view.widthAnchor.constraint(equalToConstant: productImageSize),
            view.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            view.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor, constant: -10),
            view.topAnchor.constraint(equalTo: superview.topAnchor)
            ])
    }

    func activateProductNameLabelConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10)
            ])
    }

    func activateGoodsDescriptionTableViewConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}

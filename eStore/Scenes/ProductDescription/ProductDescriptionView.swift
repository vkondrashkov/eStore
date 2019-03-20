//
//  ProductDescriptionView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductDescriptionViewImpl: UIViewController {
    var presenter: ProductDescriptionPresenter!
    var dataSource: ProductDescriptionTableViewDataSource!

    private var descriptionTableView: UITableView!

    private let productDescriptionBackgroundColor = UIColor(red: 242.0 / 255.0, green: 241.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    private let customTintColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)

    override func loadView() {
        super.loadView()
        view.backgroundColor = productDescriptionBackgroundColor
        title = "Description"
        navigationController?.navigationBar.tintColor = customTintColor

        setupDescriptionTableView()
    }

    private func setupDescriptionTableView() {
        descriptionTableView = UITableView()
        descriptionTableView.tableFooterView = UIView()
        descriptionTableView.backgroundColor = .clear
        descriptionTableView.register(ProductDescriptionTableViewCell.self, forCellReuseIdentifier: ProductDescriptionTableViewCell.reuseIdentifier)
        descriptionTableView.register(ProductDescriptionTableHeaderCell.self, forCellReuseIdentifier: ProductDescriptionTableHeaderCell.reuseIdentifier)
        descriptionTableView.register(ProductDescriptionTablePriceCell.self, forCellReuseIdentifier: ProductDescriptionTablePriceCell.reuseIdentifier)
        descriptionTableView.dataSource = dataSource
        descriptionTableView.delegate = self
        view.addSubview(descriptionTableView)
        activateDescriptionTableViewConstraints(view: descriptionTableView)
    }
}

// MARK: - ProductDescriptionView implementation
extension ProductDescriptionViewImpl: ProductDescriptionView {
    
}

// MARK: - ProductDescriptionShow implementation
extension ProductDescriptionViewImpl: ProductDescriptionShow {
    var rootViewController: UIViewController {
        return self
    }
}

// MARK: - UITableViewDelegate implementation
extension ProductDescriptionViewImpl: UITableViewDelegate {

}

// MARK: - Constraints
private extension ProductDescriptionViewImpl {
    func activateDescriptionTableViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}

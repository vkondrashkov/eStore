//
//  CatalogView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class CatalogViewImpl: UIViewController {
    var presenter: CatalogPresenter!

    private let categoryTableViewDataSource = CategoryTableViewDataSource()
    private let catalogBackgroundColor = UIColor(red: 242.0 / 255.0, green: 241.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    private var categoryTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = catalogBackgroundColor
        title = "Choose category"

        setupCategoryTableView()
    }

    private func setupCategoryTableView() {
        categoryTableView = UITableView()
        categoryTableView.tableFooterView = UIView() // Is needed to remove unnecessary separators
        categoryTableView.backgroundColor = .clear
        categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        categoryTableView.dataSource = categoryTableViewDataSource
        categoryTableView.delegate = self
        view.addSubview(categoryTableView)
        activateCatalogTableViewConstraints(view: categoryTableView)
    }
}

// MARK: - CatalogView implementation
extension CatalogViewImpl: CatalogView {
    func display(alert: Alert) {
        
    }
}

// MARK: - CatalogShow implementation
extension CatalogViewImpl: CatalogShow {
    var viewController: UIViewController {
        return self
    }
}

// MARK: - UITableViewDelegate implementation
extension CatalogViewImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Constraints
private extension CatalogViewImpl {
    func activateCatalogTableViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
    }
}

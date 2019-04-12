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
    private var categoryTableView: UITableView!

    override func loadView() {
        view = UIView()

        categoryTableView = UITableView()
        view.addSubview(categoryTableView)
        categoryTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Catalog"
        navigationController?.navigationBar.prefersLargeTitles = true

        categoryTableView.tableFooterView = UIView() // Is needed to remove unnecessary separators
        categoryTableView.backgroundColor = .clear
        categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        categoryTableView.dataSource = categoryTableViewDataSource
        categoryTableView.delegate = self

        presenter.handleLoadView()
    }
}

// MARK: - CatalogView implementation
extension CatalogViewImpl: CatalogView { }

// MARK: - ThemeSupportable implementation
extension CatalogViewImpl: ThemeSupportable {
    func apply(theme: Theme) {
        // TODO: navigationController?.navigationBar.barStyle = theme.barColor
        view.backgroundColor = theme.backgroundColor
        navigationController?.navigationBar.tintColor = theme.tintColor
        navigationController?.navigationBar.barTintColor = theme.barColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: theme.textColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: theme.textColor]
        categoryTableView.separatorColor = theme.borderColor
        categoryTableView.reloadData()
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
        presenter.handleCategoryPress(title: categoryTableViewDataSource.categories[indexPath.row].name)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

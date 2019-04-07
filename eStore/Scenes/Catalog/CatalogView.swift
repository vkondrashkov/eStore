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
        view.backgroundColor = Color.background
        title = "Catalog"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = Color.navigationBar
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Color.text]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Color.text]
        navigationController?.navigationBar.barStyle = Themes.value(from: [.light: .default, .dark: .black])

        categoryTableView.tableFooterView = UIView() // Is needed to remove unnecessary separators
        categoryTableView.backgroundColor = .clear
        categoryTableView.separatorColor = Color.border
        categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        categoryTableView.dataSource = categoryTableViewDataSource
        categoryTableView.delegate = self
    }
}

// MARK: - CatalogView implementation
extension CatalogViewImpl: CatalogView { }

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

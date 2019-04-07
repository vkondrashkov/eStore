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
        view.backgroundColor = catalogBackgroundColor
        title = "Catalog"
        navigationController?.navigationBar.prefersLargeTitles = true

        categoryTableView.tableFooterView = UIView() // Is needed to remove unnecessary separators
        categoryTableView.backgroundColor = .clear
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

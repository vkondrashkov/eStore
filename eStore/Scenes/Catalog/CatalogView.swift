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
    var theme: Theme!

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

        categoryTableViewDataSource.theme = theme

        categoryTableView.tableFooterView = UIView()
        categoryTableView.backgroundColor = .clear
        categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        categoryTableView.dataSource = categoryTableViewDataSource
        categoryTableView.delegate = self

        apply(theme: theme)
        presenter.handleLoadView()
    }

    private func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        navigationController?.navigationBar.tintColor = theme.tintColor
        navigationController?.navigationBar.barTintColor = theme.barColor
        navigationController?.navigationBar.barStyle = theme.barStyle
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: theme.textColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: theme.textColor]
        categoryTableView.separatorColor = theme.borderColor
    }
}

// MARK: - CatalogView implementation
extension CatalogViewImpl: CatalogView { }

// MARK: - ThemeUpdatable implementation
extension CatalogViewImpl: ThemeUpdatable {
    func update(theme: Theme, animated: Bool) {
        self.theme = theme
        categoryTableViewDataSource.theme = theme

        var animation: CircularFillAnimation?
        if animated {
            animation = CircularFillAnimation(
                view: view,
                position: CGPoint(x: 300, y: 545), // TODO: make tap recognizier
                contextType: .window
            )
            animation?.prepare()
        }

        apply(theme: theme)
        categoryTableView.reloadData()

        animation?.run(completion: nil)
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
        presenter.handleCategoryPress(productId: categoryTableViewDataSource.categories[indexPath.row].productId)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

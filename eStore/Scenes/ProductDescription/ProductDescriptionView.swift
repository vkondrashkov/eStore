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

    override func loadView() {
        view = UIView()

        descriptionTableView = UITableView()
        view.addSubview(descriptionTableView)
        descriptionTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Description"

        descriptionTableView.tableFooterView = UIView()
        descriptionTableView.backgroundColor = .clear
        descriptionTableView.register(ProductDescriptionTableViewCell.self, forCellReuseIdentifier: ProductDescriptionTableViewCell.reuseIdentifier)
        descriptionTableView.register(ProductDescriptionTableHeaderCell.self, forCellReuseIdentifier: ProductDescriptionTableHeaderCell.reuseIdentifier)
        descriptionTableView.register(ProductDescriptionTablePriceCell.self, forCellReuseIdentifier: ProductDescriptionTablePriceCell.reuseIdentifier)
        descriptionTableView.dataSource = dataSource
        descriptionTableView.delegate = self

        presenter.handleLoadView()
    }
}

// MARK: - ProductDescriptionView implementation
extension ProductDescriptionViewImpl: ProductDescriptionView { }

// MARK: - ThemeSupportable implementation
extension ProductDescriptionViewImpl: ThemeSupportable {
    func apply(theme: Theme, animated: Bool) {
        view.backgroundColor = theme.backgroundColor
        descriptionTableView.separatorColor = theme.borderColor
        descriptionTableView.reloadData()
    }
}

// MARK: - ProductDescriptionShow implementation
extension ProductDescriptionViewImpl: ProductDescriptionShow {
    var rootViewController: UIViewController {
        return self
    }
}

// MARK: - UITableViewDelegate implementation
extension ProductDescriptionViewImpl: UITableViewDelegate { }

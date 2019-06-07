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
    var alertFactory: AlertFactory!
    var theme: Theme!
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

        dataSource.theme = theme

        descriptionTableView.tableFooterView = UIView()
        descriptionTableView.backgroundColor = .clear
        descriptionTableView.register(ProductDescriptionTableViewCell.self, forCellReuseIdentifier: ProductDescriptionTableViewCell.reuseIdentifier)
        descriptionTableView.register(ProductDescriptionTableHeaderCell.self, forCellReuseIdentifier: ProductDescriptionTableHeaderCell.reuseIdentifier)
        descriptionTableView.register(ProductDescriptionTablePriceCell.self, forCellReuseIdentifier: ProductDescriptionTablePriceCell.reuseIdentifier)
        descriptionTableView.dataSource = dataSource
        descriptionTableView.delegate = self

        apply(theme: theme)
        presenter.handleLoadView()
    }

    private func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        descriptionTableView.separatorColor = theme.borderColor
    }
}

// MARK: - ProductDescriptionView implementation
extension ProductDescriptionViewImpl: ProductDescriptionView { }

// MARK: - ThemeUpdatable implementation
extension ProductDescriptionViewImpl: ThemeUpdatable {
    func update(theme: Theme, animated: Bool) {
        self.theme = theme
        dataSource.theme = theme

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
        descriptionTableView.reloadData()

        animation?.run(completion: nil)
    }
}

// MARK: - AlertDisplayable implementation
extension ProductDescriptionViewImpl: AlertDisplayable {
    func display(alert: Alert) {
        let alertController = alertFactory.make(alert: alert)
        present(alertController, animated: true, completion: nil)
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

// MARK: - ProductDescriptionTablePriceCellDelegate implementation
extension ProductDescriptionViewImpl: ProductDescriptionTablePriceCellDelegate {
    func cartAddButtonDidPress(_ cell: ProductDescriptionTablePriceCell) {
        presenter.cartAddButtonDidPress()
    }
}

//
//  ProductsListView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductsListViewImpl: UIViewController {
    var presenter: ProductsListPresenter!
    var theme: Theme!
    
    private var loadingView: UIView!
    private var fadeMaskView: UIView!
    private var activityIndicator: UIActivityIndicatorView!
    
    private var productsTableViewDataSource = ProductsListTableViewDataSource()
    private var productsTableView: UITableView!

    override func loadView() {
        view = UIView()

        loadingView = UIView()
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        fadeMaskView = UIView()
        loadingView.addSubview(fadeMaskView)
        fadeMaskView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        activityIndicator = UIActivityIndicatorView()
        loadingView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        productsTableView = UITableView()
        view.addSubview(productsTableView)
        productsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        loadingView.isHidden = true

        fadeMaskView.backgroundColor = UIColor(white: 0.0, alpha: 0.2)

        activityIndicator.style = .white

        productsTableViewDataSource.theme = theme

        productsTableView.tableFooterView = UIView()
        productsTableView.backgroundColor = .clear
        productsTableView.register(ProductsListTableViewCell.self, forCellReuseIdentifier: ProductsListTableViewCell.reuseIdentifier)
        productsTableView.dataSource = productsTableViewDataSource
        productsTableView.delegate = self

        apply(theme: theme)
        presenter.handleLoadView()
    }

    private func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        productsTableView.separatorColor = theme.borderColor
    }
}

// MARK: - ThemeUpdatable implementation
extension ProductsListViewImpl: ThemeUpdatable {
    func update(theme: Theme, animated: Bool) {
        self.theme = theme
        productsTableViewDataSource.theme = theme

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
        productsTableView.reloadData()

        animation?.run(completion: nil)
    }
}

// MARK: - ProductsListView implementation
extension ProductsListViewImpl: ProductsListView {
    func showActivityIndicator() {
        activityIndicator.startAnimating()
        UIView.transition(
            with: view,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                self?.loadingView.isHidden = false
                self?.productsTableView.isHidden = true
            },
            completion: nil
        )
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        UIView.transition(
            with: view,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                self?.loadingView.isHidden = true
                self?.productsTableView.isHidden = false
            },
            completion: nil
        )
    }
    
    func display(storeItemList: [StoreItem]) {
        productsTableViewDataSource.items = storeItemList
        productsTableView.reloadData()
    }
}

// MARK: - ProductsListShow implementation
extension ProductsListViewImpl: ProductsListShow {
    var rootViewController: UIViewController {
        return self
    }
}

// MARK: - UITableViewDelegate implementation
extension ProductsListViewImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.handleProductPress(storeItem: productsTableViewDataSource.items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

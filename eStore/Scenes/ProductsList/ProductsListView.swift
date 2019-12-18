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
    private let refreshControl = UIRefreshControl()

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
        productsTableView.refreshControl = refreshControl

        refreshControl.addTarget(self, action: #selector(refreshControlDidPull), for: .valueChanged)

        apply(theme: theme)
        presenter.handleLoadView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.shouldViewAppear()
    }

    private func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        productsTableView.separatorColor = theme.borderColor
    }

    // MARK: - Actions

    @objc private func rightBarButtonDidPress() {
        presenter.handleAddProductPress()
    }

    @objc private func refreshControlDidPull() {
        presenter.handleRefresh()
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

// MARK: - AlertDisplayable implementation

extension ProductsListViewImpl: AlertDisplayable {
    func display(alert: Alert) {
        let alertController = AlertFactoryImpl().make(alert: alert)
        present(alertController, animated: true, completion: nil)
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
        refreshControl.endRefreshing()
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

    func display(rightBarButtonTitle: String) {
        let rightBarButtonItem = UIBarButtonItem(
            title: rightBarButtonTitle,
            style: .plain,
            target: self,
            action: #selector(rightBarButtonDidPress)
        )
        navigationItem.rightBarButtonItem = rightBarButtonItem
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

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let actions = presenter.configureEditActions(for: indexPath)

        var tableViewRowActions: [UITableViewRowAction] = []
        for action in actions {
            let action = UITableViewRowAction(
                style: action.isDestructive ? .destructive : .normal,
                title: action.title,
                handler: { [weak self] tableRowAction, indexPath in
                    guard let self = self else { return }
                    let item = self.productsTableViewDataSource.items[indexPath.row]
                    action.action?(item)
                }
            )
            tableViewRowActions.append(action)
        }

        return tableViewRowActions
    }
}

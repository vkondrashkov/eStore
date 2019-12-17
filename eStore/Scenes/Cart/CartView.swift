//
//  CartView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class CartViewImpl: UIViewController {
    var presenter: CartPresenter!
    var alertFactory: AlertFactory!
    var theme: Theme!

    private var loadingView: UIView!
    private var fadeMaskView: UIView!
    private var activityIndicator: UIActivityIndicatorView!

    private let refreshControl = UIRefreshControl()

    private var cartTableViewDataSource = CartTableViewDataSource()
    private var cartTableView: UITableView!

    override func loadView() {
        view = UIView()

        cartTableView = UITableView()
        view.addSubview(cartTableView)
        cartTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        loadingView = UIView()
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalTo(cartTableView)
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadingView.isHidden = true

        fadeMaskView.backgroundColor = Color.silver

        activityIndicator.style = .white

        cartTableViewDataSource.theme = theme

        cartTableView.tableFooterView = UIView()
        cartTableView.backgroundColor = .clear
        cartTableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.reuseIdentifier)
        cartTableView.dataSource = cartTableViewDataSource
        cartTableView.delegate = self
        cartTableView.refreshControl = refreshControl

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
        navigationController?.navigationBar.tintColor = theme.tintColor
        navigationController?.navigationBar.barTintColor = theme.barColor
        navigationController?.navigationBar.barStyle = theme.barStyle
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: theme.textColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: theme.textColor]
        cartTableView.separatorColor = theme.borderColor
    }

    // MARK: - Actions

    @objc func refreshControlDidPull() {
        presenter.handleRefresh()
    }
}

// MARK: - CartView implementation
extension CartViewImpl: CartView {
    func showActivityIndicator() {
        activityIndicator.startAnimating()
        UIView.transition(
            with: view,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                self?.loadingView.isHidden = false
                self?.cartTableView.isHidden = true
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
                self?.cartTableView.isHidden = false
            },
            completion: nil
        )
    }

    func display(storeItemList: [StoreItem]) {
        cartTableViewDataSource.items = storeItemList
        cartTableView.reloadData()
    }
}

// MARK: - ThemeUpdatable implementation
extension CartViewImpl: ThemeUpdatable {
    func update(theme: Theme, animated: Bool) {
        self.theme = theme
        cartTableViewDataSource.theme = theme

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
        cartTableView.reloadData()

        animation?.run(completion: nil)
    }
}

// MARK: - AlertDisplayable implementation
extension CartViewImpl: AlertDisplayable {
    func display(alert: Alert) {
        let alertController = alertFactory.make(alert: alert)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - CartShow implementation
extension CartViewImpl: CartShow {
    var rootViewController: UIViewController {
        return self
    }
}

// MARK: - UITableViewDelegate implementation
extension CartViewImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.handleProductPress(storeItem: cartTableViewDataSource.items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteTitle = NSLocalizedString("Delete", comment: "Delete action")
        let deleteAction = UITableViewRowAction(
            style: .destructive,
            title: deleteTitle) { action, indexPath in
                let item = self.cartTableViewDataSource.items[indexPath.row]
                self.presenter.handleProductDelete(storeItem: item)
            }

        return [deleteAction]
    }
}

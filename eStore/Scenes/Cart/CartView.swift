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

    private var loadingView: UIView!
    private var fadeMaskView: UIView!
    private var activityIndicator: UIActivityIndicatorView!

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
        view.backgroundColor = Color.background
        navigationController?.navigationBar.tintColor = Color.shamrock
        navigationController?.navigationBar.barTintColor = Color.navigationBar
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Color.text]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Color.text]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = Themes.value(from: [.light: .default, .dark: .black])
        title = "Cart"

        loadingView.isHidden = true

        fadeMaskView.backgroundColor = Color.silver

        activityIndicator.style = .white

        cartTableView.tableFooterView = UIView()
        cartTableView.backgroundColor = .clear
        cartTableView.separatorColor = Color.border
        cartTableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.reuseIdentifier)
        cartTableView.dataSource = cartTableViewDataSource
        cartTableView.delegate = self

        presenter.handleLoadView()
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
}

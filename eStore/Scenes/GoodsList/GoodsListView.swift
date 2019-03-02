//
//  GoodsListView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class GoodsListViewImpl: UIViewController {
    var presenter: GoodsListPresenter!

    private var loadingView: UIView!
    private var fadeMaskView: UIView!
    private var activityIndicator: UIActivityIndicatorView!

    private var goodsTableViewDataSource = GoodsListTableViewDataSource() // Temporary
    private var goodsTableView: UITableView!

    private let goodsListBackgroundColor = UIColor(red: 242.0 / 255.0, green: 241.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    private let customTintColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = goodsListBackgroundColor
        navigationController?.navigationBar.tintColor = customTintColor

        setupLoadingView()
        setupFadeMaskView()
        setupActivityIndicator()
        setupGoodsTableView()

        presenter.handleLoadView()
    }

    private func setupLoadingView() {
        loadingView = UIView()
        loadingView.isHidden = true
        view.addSubview(loadingView)
        activateLoadingViewConstraints(view: loadingView)
    }

    private func setupFadeMaskView() {
        fadeMaskView = UIView()
        fadeMaskView.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        loadingView.addSubview(fadeMaskView)
        activateFadeMaskViewConstraints(view: fadeMaskView)
    }

    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .white
        loadingView.addSubview(activityIndicator)
        activateActivityIndicatorConstraints(view: activityIndicator)
    }

    private func setupGoodsTableView() {
        goodsTableView = UITableView()
        goodsTableView.tableFooterView = UIView()
        goodsTableView.backgroundColor = .clear
        goodsTableView.register(GoodsListTableViewCell.self, forCellReuseIdentifier: GoodsListTableViewCell.reuseIdentifier)
        goodsTableView.dataSource = goodsTableViewDataSource
        goodsTableView.delegate = self
        view.addSubview(goodsTableView)
        activateGoodsTableViewConstraints(view: goodsTableView)
    }
}

// MARK: - GoodsListView implementation
extension GoodsListViewImpl: GoodsListView {
    func showActivityIndicator() {
        activityIndicator.startAnimating()
        UIView.transition(
            with: view,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                self?.loadingView.isHidden = false
                self?.goodsTableView.isHidden = true
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
                self?.goodsTableView.isHidden = false
            },
            completion: nil
        )
    }
}

// MARK: - GoodsListShow implementation
extension GoodsListViewImpl: GoodsListShow {
    var rootViewController: UIViewController {
        return self
    }
}

// MARK: - UITableViewDelegate implementation
extension GoodsListViewImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Constraints
private extension GoodsListViewImpl {
    func activateLoadingViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
    }

    func activateFadeMaskViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
    }

    func activateActivityIndicatorConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ])
    }

    func activateGoodsTableViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}

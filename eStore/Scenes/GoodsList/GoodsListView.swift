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

    override func viewDidLoad() {
        super.viewDidLoad()

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
        fadeMaskView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        loadingView.addSubview(fadeMaskView)
        activateFadeMaskViewConstraints(view: fadeMaskView)
    }

    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .white
        loadingView.addSubview(activityIndicator)
        activateActivityIndicatorConstraints(view: activityIndicator)
    }
}

// MARK: - GoodsListView implementation
extension GoodsListViewImpl: GoodsListView {
    func showActivityIndicator() {
        UIView.animate(
            withDuration: 0.25,
            animations: { [weak self] in
                self?.loadingView.isHidden = false
            }
        )
    }

    func hideActivityIndicator() {
        UIView.animate(
            withDuration: 0.25,
            animations: { [weak self] in
                self?.loadingView.isHidden = true
            }
        )
    }
}

// MARK: - GoodsListShow implementation
extension GoodsListViewImpl: GoodsListShow {
    var rootViewController: UIViewController {
        return self
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
}

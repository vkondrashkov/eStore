//
//  GoodsDescriptionView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class GoodsDescriptionViewImpl: UIViewController {
    var presenter: GoodsDescriptionPresenter!
    var dataSource: GoodsDescriptionTableViewDataSource!

    private var descriptionTableView: UITableView!

    override func loadView() {
        super.loadView()

        setupDescriptionTableView()
    }

    private func setupDescriptionTableView() {
        descriptionTableView = UITableView()
        descriptionTableView.tableFooterView = UIView()
        descriptionTableView.backgroundColor = .clear
        descriptionTableView.register(GoodsDescriptionTableViewCell.self, forCellReuseIdentifier: GoodsDescriptionTableViewCell.reuseIdentifier)
        descriptionTableView.dataSource = dataSource
        descriptionTableView.delegate = self
        view.addSubview(descriptionTableView)
        activateGoodsDescriptionTableViewConstraints(view: descriptionTableView)
    }
}

// MARK: - GoodsDescriptionView implementation
extension GoodsDescriptionViewImpl: GoodsDescriptionView {
    
}

// MARK: - GoodsDescriptionShow implementation
extension GoodsDescriptionViewImpl: GoodsDescriptionShow {
    var rootViewController: UIViewController {
        return self
    }
}

// MARK: - UITableViewDelegate implementation
extension GoodsDescriptionViewImpl: UITableViewDelegate {

}

// MARK: - Constraints
private extension GoodsDescriptionViewImpl {
    func activateGoodsDescriptionTableViewConstraints(view: UIView) {
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

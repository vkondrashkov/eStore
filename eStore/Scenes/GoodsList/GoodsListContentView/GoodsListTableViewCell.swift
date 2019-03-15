//
//  GoodsListTableViewCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/26/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class GoodsListTableViewCell: UITableViewCell {
    static var reuseIdentifier = "GoodsListTableViewCellReuseIdentifier"

    private var containerView: UIView!
    private var goodsItemImageView: UIImageView!
    private var goodsItemTitleLabel: UILabel!

    private let thumbnailSize: CGFloat = 100
    private let customTintColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white

        setupContainerView()
        setupGoodsItemImageView()
        setupGoodsItemTitleLabel()
    }

    private func setupContainerView() {
        containerView = UIView()
        contentView.addSubview(containerView)
        activateContainerViewConstraints(view: containerView)
    }

    private func setupGoodsItemImageView() {
        goodsItemImageView = UIImageView()
        containerView.addSubview(goodsItemImageView)
        activateGoodsItemImageViewConstraints(view: goodsItemImageView)
    }

    private func setupGoodsItemTitleLabel() {
        goodsItemTitleLabel = UILabel()
        goodsItemTitleLabel.font = .boldSystemFont(ofSize: 17)
        goodsItemTitleLabel.numberOfLines = 0
        containerView.addSubview(goodsItemTitleLabel)
        activateGoodsItemTitleLabelConstraints(view: goodsItemTitleLabel, anchorView: goodsItemImageView)
    }

    func display(imageUrl: String?, title: String) {
        // TODO: Implement imageView download from
        // url supported by activity indicator
        goodsItemImageView.image = UIImage(named: "image-not-found")
        goodsItemTitleLabel.text = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints
private extension GoodsListTableViewCell {
    func activateContainerViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
    }

    func activateGoodsItemImageViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: thumbnailSize),
            view.heightAnchor.constraint(equalToConstant: thumbnailSize),
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -10)
            ])
    }

    func activateGoodsItemTitleLabelConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.topAnchor),
            view.leadingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10)
            ])
    }
}

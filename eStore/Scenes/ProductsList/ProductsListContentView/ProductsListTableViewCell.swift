//
//  ProductsListTableViewCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/26/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductsListTableViewCell: UITableViewCell {
    static var reuseIdentifier = "ProductsListTableViewCellReuseIdentifier"
    
    private var containerView: UIView!
    private var productImageView: UIImageView!
    private var productTitleLabel: UILabel!
    
    private let thumbnailSize: CGFloat = 100
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = Color.foreground
        
        setupContainerView()
        setupProductImageView()
        setupProductTitleLabel()
    }
    
    private func setupContainerView() {
        containerView = UIView()
        contentView.addSubview(containerView)
        activateContainerViewConstraints(view: containerView)
    }
    
    private func setupProductImageView() {
        productImageView = UIImageView()
        containerView.addSubview(productImageView)
        activateProductImageViewConstraints(view: productImageView)
    }
    
    private func setupProductTitleLabel() {
        productTitleLabel = UILabel()
        productTitleLabel.font = .boldSystemFont(ofSize: 17)
        productTitleLabel.numberOfLines = 0
        productTitleLabel.textColor = Color.text
        containerView.addSubview(productTitleLabel)
        activateProductTitleLabelConstraints(view: productTitleLabel, anchorView: productImageView)
    }
    
    func display(imageUrl: String?, title: String) {
        if let url = imageUrl {
            productImageView.downloaded(from: url)
        } else {
            productImageView.image = UIImage(named: "image-not-found")
        }
        productTitleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints
private extension ProductsListTableViewCell {
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
    
    func activateProductImageViewConstraints(view: UIView) {
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
    
    func activateProductTitleLabelConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.topAnchor),
            view.leadingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10)
            ])
    }
}

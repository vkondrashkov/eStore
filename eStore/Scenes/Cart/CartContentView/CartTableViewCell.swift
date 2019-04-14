//
//  CartTableViewCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class CartTableViewCell: UITableViewCell {
    static var reuseIdentifier = "CartTableViewCellReuseIdentifier"

    private var productImageView: UIImageView!
    private var productPriceLabel: UILabel!
    private var productTitleLabel: UILabel!

    private let thumbnailSize: CGFloat = 100

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        setupProductImageView()
        setupProductPriceLabel()
        setupProductTitleLabel()
    }

    private func setupProductImageView() {
        productImageView = UIImageView()
        contentView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(thumbnailSize)
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    private func setupProductPriceLabel() {
        productPriceLabel = UILabel()
        productPriceLabel.font = .boldSystemFont(ofSize: 17)
        productPriceLabel.textAlignment = .right
        contentView.addSubview(productPriceLabel)
        productPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView).offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
    }

    private func setupProductTitleLabel() {
        productTitleLabel = UILabel()
        productTitleLabel.font = .boldSystemFont(ofSize: 17)
        productTitleLabel.numberOfLines = 0
        contentView.addSubview(productTitleLabel)
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(productImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(productPriceLabel.snp.top).offset(-10)
        }
    }

    func apply(theme: Theme) {
        contentView.backgroundColor = theme.foregroundColor
        productPriceLabel.textColor = theme.textColor
        productTitleLabel.textColor = theme.textColor
    }

    func display(imageUrl: String?, title: String, price: String) {
        if let url = imageUrl {
            productImageView.downloaded(from: url)
        } else {
            productImageView.image = UIImage(named: "image-not-found")
        }
        productTitleLabel.text = title
        productPriceLabel.text = price
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

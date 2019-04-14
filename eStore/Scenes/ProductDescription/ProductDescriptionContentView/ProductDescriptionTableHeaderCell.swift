//
//  ProductDescriptionTableHeaderCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/15/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductDescriptionTableHeaderCell: UITableViewCell {
    static var reuseIdentifier = "ProductDescriptionTableHeaderCellReuseIdentifier"
    
    private var productTitleLabel: UILabel!
    private var productImageView: UIImageView!
    
    private let imageSize: CGFloat = 300

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupProductImageView()
        setupProductTitleLabel()
    }
    
    private func setupProductImageView() {
        productImageView = UIImageView()
        contentView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(imageSize)
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
        }
    }
    
    private func setupProductTitleLabel() {
        productTitleLabel = UILabel()
        productTitleLabel.font = .boldSystemFont(ofSize: 22)
        productTitleLabel.numberOfLines = 0
        productTitleLabel.textAlignment = .center
        contentView.addSubview(productTitleLabel)
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
    }

    func apply(theme: Theme) {
        backgroundColor = theme.foregroundColor
        contentView.backgroundColor = theme.foregroundColor
        productTitleLabel.textColor = theme.textColor
    }
    
    func display(title: String, imageUrl: String?) {
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

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
        
        setupContainerView()
        setupProductImageView()
        setupProductTitleLabel()
    }
    
    private func setupContainerView() {
        containerView = UIView()
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupProductImageView() {
        productImageView = UIImageView()
        containerView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(thumbnailSize)
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func setupProductTitleLabel() {
        productTitleLabel = UILabel()
        productTitleLabel.font = .boldSystemFont(ofSize: 17)
        productTitleLabel.numberOfLines = 0
        containerView.addSubview(productTitleLabel)
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.top)
            make.leading.equalTo(productImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }

    func apply(theme: Theme) {
        contentView.backgroundColor = theme.foregroundColor
        productTitleLabel.textColor = theme.textColor
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

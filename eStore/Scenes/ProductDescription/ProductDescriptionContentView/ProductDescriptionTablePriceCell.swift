//
//  ProductDescriptionTablePriceCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductDescriptionTablePriceCell: UITableViewCell {
    static var reuseIdentifier = "ProductDescriptionTablePriceCellReuseIdentifier"

    private var priceLabel: UILabel!
    private var cartAddButton: UIButton!
    private var stockAvailableLabel: UILabel!
    
    private let customTintColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
    private let cartAddButtonActiveBackgroundColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
    private let cartAddButtonDisabledBackgroundColor = UIColor(red: 189.0 / 255.0, green: 195.0 / 255.0, blue: 199.0 / 255.0, alpha: 1.0)
    private let stockAvailableLabelDisabledColor = UIColor(red: 231.0 / 255.0, green: 76.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
    private let stockAvailableLabelActiveColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
    
    private let cartAddButtonContentInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupPriceLabel()
        setupCartAddButton()
        setupStockAvailableLabel()
    }
    
    private func setupPriceLabel() {
        priceLabel = UILabel()
        priceLabel.font = .boldSystemFont(ofSize: 17)
        priceLabel.textAlignment = .center
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func setupCartAddButton() {
        cartAddButton = UIButton()
        cartAddButton.layer.cornerRadius = 8
        cartAddButton.contentEdgeInsets = cartAddButtonContentInset
        cartAddButton.backgroundColor = cartAddButtonDisabledBackgroundColor
        cartAddButton.addTarget(self, action: #selector(cartAddButtonDidPress), for: .touchUpInside)
        contentView.addSubview(cartAddButton)
        cartAddButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func setupStockAvailableLabel() {
        stockAvailableLabel = UILabel()
        stockAvailableLabel.font = .systemFont(ofSize: 14)
        stockAvailableLabel.textColor = stockAvailableLabelDisabledColor
        stockAvailableLabel.textAlignment = .center
        contentView.addSubview(stockAvailableLabel)
        stockAvailableLabel.snp.makeConstraints { make in
            make.top.equalTo(cartAddButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.trailing.equalToSuperview().offset(-10)
        }
    }

    func apply(theme: Theme) {
        backgroundColor = theme.foregroundColor
        contentView.backgroundColor = theme.foregroundColor
        priceLabel.textColor = theme.textColor
    }
    
    func display(price: String) {
        priceLabel.text = price
    }
    
    func display(cartAddButtonText: String, isAvailable: Bool) {
        cartAddButton.setTitle(cartAddButtonText, for: .normal)
        cartAddButton.isEnabled = isAvailable
        cartAddButton.backgroundColor = isAvailable ? cartAddButtonActiveBackgroundColor : cartAddButtonDisabledBackgroundColor
    }
    
    func display(stockAvailableText: String, isAvailable: Bool) {
        stockAvailableLabel.text = stockAvailableText
        stockAvailableLabel.textColor = isAvailable ? stockAvailableLabelActiveColor : stockAvailableLabelDisabledColor
    }
    
    @objc private func cartAddButtonDidPress() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

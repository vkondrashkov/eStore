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
    
    private var containerView: UIView!
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
        backgroundColor = .clear
        
        setupContainerView()
        setupPriceLabel()
        setupCartAddButton()
        setupStockAvailableLabel()
    }
    
    private func setupContainerView() {
        containerView = UIView()
        contentView.addSubview(containerView)
        activateContainerViewConstraints(view: containerView)
    }
    
    private func setupPriceLabel() {
        priceLabel = UILabel()
        priceLabel.font = .boldSystemFont(ofSize: 17)
        priceLabel.textAlignment = .center
        containerView.addSubview(priceLabel)
        activatePriceLabelConstraints(view: priceLabel)
    }
    
    private func setupCartAddButton() {
        cartAddButton = UIButton()
        cartAddButton.layer.cornerRadius = 8
        cartAddButton.contentEdgeInsets = cartAddButtonContentInset
        cartAddButton.backgroundColor = cartAddButtonDisabledBackgroundColor
        cartAddButton.addTarget(self, action: #selector(cartAddButtonDidPress), for: .touchUpInside)
        containerView.addSubview(cartAddButton)
        activateCartAddButtonConstraints(view: cartAddButton, anchorView: priceLabel)
    }
    
    private func setupStockAvailableLabel() {
        stockAvailableLabel = UILabel()
        stockAvailableLabel.font = .systemFont(ofSize: 14)
        stockAvailableLabel.textColor = stockAvailableLabelDisabledColor
        stockAvailableLabel.textAlignment = .center
        containerView.addSubview(stockAvailableLabel)
        activateStockAvailableLabelConstraints(view: stockAvailableLabel, anchorView: cartAddButton)
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

// MARK: - ThemeSupportable implementation
extension ProductDescriptionTablePriceCell: ThemeSupportable {
    func apply(theme: Theme, animated: Bool) {
        contentView.backgroundColor = theme.foregroundColor
        priceLabel.textColor = theme.textColor
    }
}

// MARK: - Constraints
private extension ProductDescriptionTablePriceCell {
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
    
    func activatePriceLabelConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10)
            ])
    }
    
    func activateCartAddButtonConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10)
            ])
    }
    
    func activateStockAvailableLabelConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 5),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10)
            ])
    }
}

//
//  ProductDescriptionTableViewCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductDescriptionTableViewCell: UITableViewCell {
    static var reuseIdentifier = "ProductDescriptionTableViewCellReuseIdentifier"
    
    private var propertyNameLabel: UILabel!
    private var propertyValueLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupPropertyNameLabel()
        setupPropertyValueLabel()
    }
    
    private func setupPropertyNameLabel() {
        propertyNameLabel = UILabel()
        propertyNameLabel.font = .boldSystemFont(ofSize: 17)
        contentView.addSubview(propertyNameLabel)
        propertyNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalTo(contentView.snp.centerX).offset(-10)
        }
    }
    
    private func setupPropertyValueLabel() {
        propertyValueLabel = UILabel()
        propertyValueLabel.font = .systemFont(ofSize: 17)
        contentView.addSubview(propertyValueLabel)
        propertyValueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(propertyNameLabel.snp.trailing).offset(10)
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalToSuperview().offset(-10)
        }
    }

    func apply(theme: Theme) {
        backgroundColor = theme.foregroundColor
        contentView.backgroundColor = theme.foregroundColor
        propertyNameLabel.textColor = theme.textColor
        propertyValueLabel.textColor = theme.textColor
    }
    
    func display(name: String, value: String) {
        propertyNameLabel.text = name
        propertyValueLabel.text = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

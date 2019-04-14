//
//  CategoryTableViewCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    static var reuseIdentifier = "CategoryTableViewCellReuseIdentifier"

    private var iconImageView: UIImageView!
    private var descriptionLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        setupIconImageView()
        setupDescriptionLabel()
    }

    private func setupIconImageView() {
        iconImageView = UIImageView()
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(iconImageView.snp.height)
        }
    }

    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.font = .boldSystemFont(ofSize: 17)
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
    }

    func apply(theme: Theme) {
        contentView.backgroundColor = theme.foregroundColor
        descriptionLabel.textColor = theme.textColor
        iconImageView.tintColor = theme.tintColor
    }

    func display(iconUrl: String?, description: String) {
        descriptionLabel.text = description
        if let url = iconUrl, let icon = UIImage(named: url) {
            iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
        } else {
            iconImageView.image = UIImage(named: "error-icon")!.withRenderingMode(.alwaysTemplate)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

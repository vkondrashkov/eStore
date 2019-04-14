//
//  ProfileRegularCategoryTableViewCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileRegularCategoryTableViewCell: UITableViewCell {
    static var reuseIdentifier = "ProfileRegularCategoryTableViewCellReuseIdentifier"

    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!

    private let iconImageSize: CGFloat = 32

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupIconImageView()
        setupTitleLabel()
    }

    private func setupIconImageView() {
        iconImageView = UIImageView()
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(iconImageSize)
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 17)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }

    func apply(theme: Theme) {
        backgroundColor = theme.foregroundColor
        contentView.backgroundColor = theme.foregroundColor
        titleLabel.textColor = theme.textColor
        iconImageView.tintColor = theme.tintColor
    }

    func display(iconImageUrl: String?, title: String) {
        if let url = iconImageUrl, let icon = UIImage(named: url) {
            iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
        } else {
            iconImageView.image = UIImage(named: "error-icon")!.withRenderingMode(.alwaysTemplate)
        }
        titleLabel.text = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

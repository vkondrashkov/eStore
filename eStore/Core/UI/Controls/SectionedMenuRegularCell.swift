//
//  SectionedMenuRegularCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SectionedMenuRegularCell: UITableViewCell, ReuseIdentifiable {
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
        let selectedView = UIView()
        selectedView.backgroundColor = theme.textColor.withAlphaComponent(0.20)
        selectedBackgroundView = selectedView
    }

    func display(iconName: String, title: String?) {
        iconImageView.image = UIImage(named: iconName)!.withRenderingMode(.alwaysTemplate)
        titleLabel.text = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

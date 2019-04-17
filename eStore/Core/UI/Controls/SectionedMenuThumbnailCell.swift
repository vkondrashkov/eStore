//
//  SectionedMenuThumbnailCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/18/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SectionedMenuThumbnailCell: UITableViewCell {
    static var reuseIdentifier = "SectionedMenuThumbnailCellReuseIdentifier"

    private var thumbnailImageView: UIImageView!
    private var titleLabel: UILabel!

    private let thumbnailImageSize: CGFloat = 64

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupThumbnailImageView()
        setupTitleLabel()
    }

    private func setupThumbnailImageView() {
        thumbnailImageView = UIImageView()
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.contentMode = .center
        thumbnailImageView.layer.cornerRadius = thumbnailImageSize / 2
        thumbnailImageView.layer.borderWidth = 1.0
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints { make in
            make.width.height.equalTo(thumbnailImageSize)
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(thumbnailImageView.snp.centerY)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }

    func apply(theme: Theme) {
        backgroundColor = theme.foregroundColor
        contentView.backgroundColor = theme.foregroundColor
        thumbnailImageView.layer.borderColor = theme.borderColor.cgColor
        titleLabel.textColor = theme.textColor
    }

    func display(thumbnailImageUrl: String?, title: String?) {
        if let url = thumbnailImageUrl {
            thumbnailImageView.downloaded(from: url)
        } else {
            thumbnailImageView.image = UIImage(named: "default-user-icon")
        }
        titleLabel.text = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

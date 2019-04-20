//
//  ThemeSettingsColorPickerViewCell.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ThemeSettingsColorPickerViewCell: UICollectionViewCell {
    static var reuseIdentifier = "ThemeSettingsColorPickerViewCellReuseIdentifier"

    private var colorPick: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        colorPick = UIView()
        contentView.addSubview(colorPick)
        colorPick.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        colorPick.layer.cornerRadius = contentView.frame.height / 2
        colorPick.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(color: UIColor) {
        colorPick.backgroundColor = color
    }
}

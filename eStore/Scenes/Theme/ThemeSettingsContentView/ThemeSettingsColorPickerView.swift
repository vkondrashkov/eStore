//
//  ThemeSettingsColorPickerView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ThemeSettingsColorPickerView: UICollectionView {
    var items: [TintColorType] = []

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .clear

        register(ThemeSettingsColorPickerViewCell.self)

        dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource implementation
extension ThemeSettingsColorPickerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ThemeSettingsColorPickerViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.display(color: items[indexPath.row].color)
        return cell
    }
}

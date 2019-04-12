//
//  CartTableViewDataSource.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class CartTableViewDataSource: NSObject, UITableViewDataSource {
    private let themeManager = ThemeManagerImpl()
    var items: [StoreItem] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.reuseIdentifier, for: indexPath) as! CartTableViewCell
        let item = items[indexPath.row]
        cell.apply(theme: themeManager.currentTheme)
        cell.display(
            imageUrl: item.imageUrl,
            title: "\(item.brand) \(item.name)",
            price: "\(item.price) BYN"
        )
        return cell
    }
}


//
//  CategoryTableViewDataSource.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class CategoryTableViewDataSource: NSObject, UITableViewDataSource {
    private let themeManager = ThemeManagerImpl() // TODO: dependency injection
    var categories: [Category] = [
        Category(iconUrl: "smartphone-icon", name: "Smartphone"),
        Category(iconUrl: "tv-icon", name: "TV"),
        Category(iconUrl: "laptop-icon", name: "Laptop")
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoryTableViewCell()
        cell.display(iconUrl: categories[indexPath.row].iconUrl, description: categories[indexPath.row].name)
        cell.apply(theme: themeManager.currentTheme)
        return cell
    }
}

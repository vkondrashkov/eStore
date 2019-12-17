//
//  CategoryTableViewDataSource.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class CategoryTableViewDataSource: NSObject, UITableViewDataSource {
    var theme: Theme!
    var categories: [Category] = [
        Category(iconUrl: "smartphone-icon", name: "Smartphone", productId: 0),
        Category(iconUrl: "laptop-icon", name: "Laptop", productId: 1),
        Category(iconUrl: "tv-icon", name: "TV", productId: 2)
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoryTableViewCell()
        cell.display(iconUrl: categories[indexPath.row].iconUrl, description: categories[indexPath.row].name)
        cell.apply(theme: theme)
        return cell
    }
}

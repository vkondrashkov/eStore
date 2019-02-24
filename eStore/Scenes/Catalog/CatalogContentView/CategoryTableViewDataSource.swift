//
//  CategoryTableViewDataSource.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class CategoryTableViewDataSource: NSObject, UITableViewDataSource {
    var categories: [Category] = [
        Category(icon: nil, name: "Smartphone"),
        Category(icon: nil, name: "TV"),
        Category(icon: nil, name: "Laptop")
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoryTableViewCell()
        cell.display(icon: categories[indexPath.row].icon, description: categories[indexPath.row].name)
        return cell
    }
}


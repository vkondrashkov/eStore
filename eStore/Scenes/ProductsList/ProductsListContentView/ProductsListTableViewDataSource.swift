//
//  ProductsListTableViewDataSource.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/2/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class ProductsListTableViewDataSource: NSObject, UITableViewDataSource {
    var items: [StoreItem] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductsListTableViewCell.reuseIdentifier, for: indexPath) as! ProductsListTableViewCell
        let item = items[indexPath.row]
        cell.display(imageUrl: item.imageUrl, title: "\(item.brand) \(item.name)") // TODO: implement display(_:) method
        return cell
    }
}


//
//  GoodsDescriptionTableViewDataSource.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class GoodsDescriptionTableViewDataSource<Item: StoreItem & PropertyReflectable>: NSObject, UITableViewDataSource {
    var item: Item!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.properties.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoodsDescriptionTableViewCell.reuseIdentifier, for: indexPath) as! GoodsDescriptionTableViewCell
        let key = item.properties[indexPath.row]
        var value = ""
        if let display = item[key] as? Display {
            value = display.description
        } else {
            value = item[key] as? String ?? "unknown"
        }
        cell.display(name: key, value: value)

        return cell
    }
}

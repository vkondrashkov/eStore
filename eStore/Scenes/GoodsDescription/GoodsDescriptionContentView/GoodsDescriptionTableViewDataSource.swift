//
//  GoodsDescriptionTableViewDataSource.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class GoodsDescriptionTableViewDataSource: NSObject, UITableViewDataSource {
    var item: StoreItem!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.specifications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoodsDescriptionTableViewCell.reuseIdentifier, for: indexPath) as! GoodsDescriptionTableViewCell
        let specification = item.specifications[indexPath.row]
        var value = ""
        switch specification.value {
        case let someString as String:
            value = someString
        case let someInt as Int:
            value = String(someInt)
        case let someDisplay as Display:
            value = "\(someDisplay.width)x\(someDisplay.height)"
        case let someOs as OperatingSystem:
            value = someOs.rawValue
        default:
            value = "unknown"
        }
        cell.display(name: specification.name, value: value)

        return cell
    }
}

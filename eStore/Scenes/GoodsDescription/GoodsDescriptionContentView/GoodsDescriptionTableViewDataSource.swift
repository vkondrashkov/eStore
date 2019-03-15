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
        return item.specifications.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row > 0 else {
            let header = tableView.dequeueReusableCell(withIdentifier: GoodsDescriptionTableHeaderCell.reuseIdentifier, for: indexPath) as! GoodsDescriptionTableHeaderCell
            header.display(title: "\(item.brand) \(item.name)", imageUrl: nil)
            header.isUserInteractionEnabled = false
            return header
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: GoodsDescriptionTableViewCell.reuseIdentifier, for: indexPath) as! GoodsDescriptionTableViewCell
        let specification = item.specifications[indexPath.row - 1]
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
        cell.isUserInteractionEnabled = false
        return cell
    }
}

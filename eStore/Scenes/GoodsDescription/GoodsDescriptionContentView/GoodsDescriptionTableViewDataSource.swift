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
        return item.specifications.count + 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let header = tableView.dequeueReusableCell(withIdentifier: GoodsDescriptionTableHeaderCell.reuseIdentifier, for: indexPath) as! GoodsDescriptionTableHeaderCell
            header.display(title: "\(item.brand) \(item.name)", imageUrl: "https://content2.onliner.by/catalog/device/header@2/0ab0b43eb38b5767ea29c4509f0a9d3b.jpeg")
            header.isUserInteractionEnabled = false
            return header
        }
        if indexPath.row == 1 {
            let price = tableView.dequeueReusableCell(withIdentifier: GoodsDescriptionTablePriceCell.reuseIdentifier, for: indexPath) as! GoodsDescriptionTablePriceCell
            let isAvailable = true // Temp
            price.display(price: "Price: \(item.price) BYN")
            price.display(cartAddButtonText: "Add to cart", isAvailable: isAvailable)
            let stockAvailableText = isAvailable ? "Available" : "Not available"
            price.display(stockAvailableText: stockAvailableText, isAvailable: isAvailable)
            price.isUserInteractionEnabled = false
            return price
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: GoodsDescriptionTableViewCell.reuseIdentifier, for: indexPath) as! GoodsDescriptionTableViewCell
        let specification = item.specifications[indexPath.row - 2]
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

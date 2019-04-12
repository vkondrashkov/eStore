//
//  ProductDescriptionTableViewDataSource.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class ProductDescriptionTableViewDataSource: NSObject, UITableViewDataSource {
    private let themeManager = ThemeManagerImpl() // TODO: dependency injection
    var item: StoreItem!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.specifications.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let header = tableView.dequeueReusableCell(withIdentifier: ProductDescriptionTableHeaderCell.reuseIdentifier, for: indexPath) as! ProductDescriptionTableHeaderCell
            header.display(title: "\(item.brand) \(item.name)", imageUrl: item.imageUrl)
            header.apply(theme: themeManager.currentTheme, animated: false)
            header.isUserInteractionEnabled = false
            return header
        }
        if indexPath.row == 1 {
            let price = tableView.dequeueReusableCell(withIdentifier: ProductDescriptionTablePriceCell.reuseIdentifier, for: indexPath) as! ProductDescriptionTablePriceCell
            let isAvailable = item.stockCount != 0
            let stockAvailableText = isAvailable ? "Available" : "Not available"
            price.display(price: "Price: \(item.price) BYN")
            price.display(cartAddButtonText: "Add to cart", isAvailable: isAvailable)
            price.display(stockAvailableText: stockAvailableText, isAvailable: isAvailable)
            price.apply(theme: themeManager.currentTheme, animated: false)
            price.isUserInteractionEnabled = false
            return price
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductDescriptionTableViewCell.reuseIdentifier, for: indexPath) as! ProductDescriptionTableViewCell
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
        cell.apply(theme: themeManager.currentTheme, animated: false)
        cell.display(name: specification.name, value: value)
        cell.isUserInteractionEnabled = false
        return cell
    }
}

//
//  GoodsListTableViewDataSource.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/2/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class GoodsListTableViewDataSource: NSObject, UITableViewDataSource {
    var items: [StoreItem] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoodsListTableViewCell.reuseIdentifier, for: indexPath) as! GoodsListTableViewCell
        let item = items[indexPath.row]
        cell.display(imageUrl: "https://content2.onliner.by/catalog/device/header@2/0ab0b43eb38b5767ea29c4509f0a9d3b.jpeg", title: "\(item.brand) \(item.name)") // TODO: implement display(_:) method
        return cell
    }
}


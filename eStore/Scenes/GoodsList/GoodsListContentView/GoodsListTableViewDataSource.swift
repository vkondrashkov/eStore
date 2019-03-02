//
//  GoodsListTableViewDataSource.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/2/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class GoodsListTableViewDataSource: NSObject, UITableViewDataSource {
    var items: [String] = [
        "Goods",
        "Goods",
        "Goods",
        "Goods",
        "Goods",
        "Goods",
        "Goods",
        "Goods",
        "Goods",
        "Goods"
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GoodsListTableViewCell()
        cell.display(imageUrl: nil, title: items[indexPath.row])
        return cell
    }
}


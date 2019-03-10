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


        return cell
    }
}

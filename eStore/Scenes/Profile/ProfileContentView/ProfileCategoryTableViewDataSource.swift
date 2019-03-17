//
//  ProfileCategoryTableViewDataSource.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class ProfileCategoryTableViewDataSource: NSObject, UITableViewDataSource {
    var items: [ProfileCategory] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCategoryTableViewCell.reuseIdentifier, for: indexPath) as! ProfileCategoryTableViewCell
        cell.display(iconImageUrl: item.iconUrl, title: item.name)
        return cell
    }
}

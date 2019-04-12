//
//  ProfileCategoryTableViewDataSource.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class ProfileCategoryTableViewDataSource: NSObject, UITableViewDataSource {
    private let themeManager = ThemeManagerImpl() // TODO: Think over of correct injection
    var items: [ProfileSection] = []

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].name
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section].categories[indexPath.row]
        let currentTheme = themeManager.currentTheme
        switch item.type {
        case .regular:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileRegularCategoryTableViewCell.reuseIdentifier, for: indexPath) as! ProfileRegularCategoryTableViewCell
            cell.display(iconImageUrl: item.iconUrl, title: item.name)
            cell.apply(theme: currentTheme)
            return cell
        case .thumbnail:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileThumbnailCategoryTableViewCell.reuseIdentifier, for: indexPath) as! ProfileThumbnailCategoryTableViewCell
            cell.display(thumbnailImageUrl: item.iconUrl, title: item.name)
            cell.apply(theme: currentTheme)
            return cell
        case .warning:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileWarningCategoryTableViewCell.reuseIdentifier, for: indexPath) as! ProfileWarningCategoryTableViewCell
            cell.display(iconImageUrl: item.iconUrl, title: item.name)
            cell.apply(theme: currentTheme)
            return cell
        }
    }
}

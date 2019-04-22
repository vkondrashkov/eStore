//
//  SectionedMenuTableViewAdapter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/22/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SectionedMenuTableViewAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    var sections: [SectionedMenuSection] = []
    var theme: Theme!

    // MARK: - UITableViewDataSource implementation
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
        switch item.type {
        case .regular:
            let cell = tableView.dequeueReusableCell(withIdentifier: SectionedMenuRegularCell.reuseIdentifier, for: indexPath) as! SectionedMenuRegularCell
            cell.apply(theme: theme)
            cell.display(iconImageUrl: item.imageUrl, title: item.title)
            return cell
        case .colorPicker:
            let cell = tableView.dequeueReusableCell(withIdentifier: SectionedMenuColorPickerCell.reuseIdentifier, for: indexPath) as! SectionedMenuColorPickerCell
            cell.apply(theme: theme)
            cell.display(iconImageUrl: item.imageUrl, title: item.title)
            return cell
        case .thumbnail:
            let cell = tableView.dequeueReusableCell(withIdentifier: SectionedMenuThumbnailCell.reuseIdentifier, for: indexPath) as! SectionedMenuThumbnailCell
            cell.apply(theme: theme)
            cell.display(thumbnailImageUrl: item.imageUrl, title: item.title)
            return cell
        }
    }

    // MARK: - UITableViewDelegate implementation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

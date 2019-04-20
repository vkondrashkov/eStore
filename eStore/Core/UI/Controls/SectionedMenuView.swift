//
//  SectionedMenuView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

enum SectionedMenuRowType {
    case thumbnail
    case regular
    case colorPicker
}

struct SectionedMenuSection {
    let title: String?
    let items: [SectionedMenuRow]
}

struct SectionedMenuRow {
    let imageUrl: String?
    let title: String?
    let type: SectionedMenuRowType
    let action: ((_ point: CGPoint) -> Void)?

    init(imageUrl: String?,
         title: String?,
         type: SectionedMenuRowType = .regular,
         action: ((_ point: CGPoint) -> Void)?) {

        self.imageUrl = imageUrl
        self.title = title
        self.type = type
        self.action = action
    }
}

final class SectionedMenuView: UITableView {
    var theme: Theme!
    var sections: [SectionedMenuSection] = []

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        register(SectionedMenuRegularCell.self, forCellReuseIdentifier: SectionedMenuRegularCell.reuseIdentifier)
        register(SectionedMenuColorPickerCell.self, forCellReuseIdentifier: SectionedMenuColorPickerCell.reuseIdentifier)
        register(SectionedMenuThumbnailCell.self, forCellReuseIdentifier: SectionedMenuThumbnailCell.reuseIdentifier)
        
        delegate = self
        dataSource = self


        let sectionedMenuGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sectionedMenuDidTap(sender:)))
        sectionedMenuGestureRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(sectionedMenuGestureRecognizer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func sectionedMenuDidTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: self) // point of touch in tableView
        guard let indexPath = indexPathForRow(at: location) else {
            return
        }
        let windowPoint = self.convert(location, to: self.window)
        sections[indexPath.section].items[indexPath.row].action?(windowPoint)
    }
}

// MARK: - UITableViewDelegate implementation
// TODO: Make proxying if needed
extension SectionedMenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource implementation
// TODO: Make proxying if needed
extension SectionedMenuView: UITableViewDataSource {
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
}

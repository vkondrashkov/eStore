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
    private var adapter = SectionedMenuTableViewAdapter()
    
    var theme: Theme! {
        didSet {
            adapter.theme = self.theme
        }
    }

    var sections: [SectionedMenuSection] {
        didSet {
            adapter.sections = self.sections
        }
    }

    override init(frame: CGRect, style: UITableView.Style) {
        sections = []
        super.init(frame: frame, style: style)

        register(SectionedMenuRegularCell.self)
        register(SectionedMenuColorPickerCell.self)
        register(SectionedMenuThumbnailCell.self)
        
        delegate = adapter
        dataSource = adapter

        let sectionedMenuGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sectionedMenuDidTap(sender:)))
        sectionedMenuGestureRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(sectionedMenuGestureRecognizer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func sectionedMenuDidTap(sender: UITapGestureRecognizer) {
        let tableTapPoint = sender.location(in: self)
        guard let indexPath = indexPathForRow(at: tableTapPoint) else {
            return
        }
        let windowTapPoint = self.convert(tableTapPoint, to: self.window)
        sections[indexPath.section].items[indexPath.row].action?(windowTapPoint)
    }
}

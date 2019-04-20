//
//  ThemeView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/7/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ThemeSettingsViewImpl: UIViewController {
    var presenter: ThemeSettingsPresenter!
    var theme: Theme!

    private var themeSectionedMenu: SectionedMenuView!

    override func loadView() {
        view = UIView()

        themeSectionedMenu = SectionedMenuView(frame: .zero, style: .grouped)
        view.addSubview(themeSectionedMenu)
        themeSectionedMenu.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Theme settings"
        navigationItem.largeTitleDisplayMode = .never

        themeSectionedMenu.tableFooterView = UIView() // Is needed to remove unnecessary separators
        themeSectionedMenu.backgroundColor = .clear
        themeSectionedMenu.theme = theme

        apply(theme: theme)
        presenter.handleLoadView()
    }

    private func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        navigationController?.navigationBar.tintColor = theme.tintColor
        navigationController?.navigationBar.barTintColor = theme.barColor
        navigationController?.navigationBar.barStyle = theme.barStyle
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: theme.textColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: theme.textColor]
        themeSectionedMenu.separatorColor = theme.borderColor
    }
}

// MARK: - ThemeSettingsView implementation
extension ThemeSettingsViewImpl: ThemeSettingsView {
    func display(sections: [SectionedMenuSection]) {
        themeSectionedMenu.sections = sections
        themeSectionedMenu.reloadData()
    }

    func display(alert: Alert) {
        let alertController = AlertFactory().make(alert: alert)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - ThemeUpdatable implementation
extension ThemeSettingsViewImpl: ThemeUpdatable {
    func update(theme: Theme, animated: Bool) {
        self.theme = theme
        themeSectionedMenu.theme = theme

        var animation: CircularFillAnimation?
        if animated {
            animation = CircularFillAnimation(
                view: view,
                position: CGPoint(x: 300, y: 545), // TODO: make tap recognizier
                contextType: .window
            )
            animation?.prepare()
        }

        apply(theme: theme)
        themeSectionedMenu.reloadData()

        animation?.run(completion: nil)
    }
}

// MARK: - ThemeSettingsShow implementation
extension ThemeSettingsViewImpl: ThemeSettingsShow {
    var viewController: UIViewController {
        return self
    }
}

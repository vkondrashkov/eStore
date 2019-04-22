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
    private var colorPickerItems: [TintColorType] = []

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

        themeSectionedMenu.tableFooterView = UIView()
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

    func display(colorPickerItems: [TintColorType]) {
        self.colorPickerItems = colorPickerItems

        let alertController = UIAlertController(title: "Pick an Accent Color", message: nil, preferredStyle: .actionSheet)

        let colorPickerLayout = UICollectionViewFlowLayout()
        colorPickerLayout.itemSize = CGSize(width: 64, height: 64)
        let colorPickerView = ThemeSettingsColorPickerView(
            frame: .zero,
            collectionViewLayout: colorPickerLayout
        )
        colorPickerView.delegate = self
        colorPickerView.items = colorPickerItems

        alertController.view.addSubview(colorPickerView)
        colorPickerView.snp.makeConstraints { make in // TODO: Change to relative constraints
            make.top.equalToSuperview().offset(45)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(140)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    func update(theme: Theme, from point: CGPoint, animated: Bool) {
        self.theme = theme
        themeSectionedMenu.theme = theme

        var animation: CircularFillAnimation?
        if animated {
            animation = CircularFillAnimation(
                view: view,
                position: point,
                contextType: .window
            )
            animation?.prepare()
        }

        apply(theme: theme)
        themeSectionedMenu.reloadData()

        animation?.run(completion: nil)
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
                position: CGPoint(x: 300, y: 545),
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

// MARK: - UICollectionViewDelegate implementation
extension ThemeSettingsViewImpl: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !colorPickerItems.isEmpty else { return }
        presenter.handlePickedTintColor(tintColorType: colorPickerItems[indexPath.row])
    }
}

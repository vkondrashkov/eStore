//
//  ProfileView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileViewImpl: UIViewController {
    var presenter: ProfilePresenter!
    var theme: Theme!
    
    private var profileSectionedMenu: SectionedMenuView!

    override func loadView() {
        view = UIView()

        profileSectionedMenu = SectionedMenuView(frame: .zero, style: .grouped)
        view.addSubview(profileSectionedMenu)
        profileSectionedMenu.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true

        profileSectionedMenu.tableFooterView = UIView() // Is needed to remove unnecessary separators
        profileSectionedMenu.backgroundColor = .clear
        profileSectionedMenu.theme = theme

        apply(theme: theme)
        presenter.handleLoadView()
    }

    @objc private func rightBarButtonDidPressed() {
        presenter.handleRightBarButtonPress()
    }

    private func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        navigationController?.navigationBar.tintColor = theme.tintColor
        navigationController?.navigationBar.barTintColor = theme.barColor
        navigationController?.navigationBar.barStyle = theme.barStyle
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: theme.textColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: theme.textColor]
        profileSectionedMenu.separatorColor = theme.borderColor
    }
}

// MARK: - ProfileView implementation
extension ProfileViewImpl: ProfileView {
    func display(rightBarButton: String) {
        let rightBarButtonItem = UIBarButtonItem(title: rightBarButton,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(rightBarButtonDidPressed))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func display(sections: [SectionedMenuSection]) {
        profileSectionedMenu.sections = sections
        profileSectionedMenu.reloadData()
    }

    func display(alert: Alert) {
        let alertController = AlertFactory().make(alert: alert)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - ThemeUpdatable implementation
extension ProfileViewImpl: ThemeUpdatable {
    func update(theme: Theme, animated: Bool) {
        self.theme = theme
        profileSectionedMenu.theme = theme

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
        profileSectionedMenu.reloadData()

        animation?.run(completion: nil)
    }
}

// MARK: - ProfileShow implementation
extension ProfileViewImpl: ProfileShow {
    var viewController: UIViewController {
        return self
    }
}

//
//  DashboardView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DashboardViewImpl: UITabBarController {
    var presenter: DashboardPresenter!
    var theme: Theme!

    var catalogNavigation: UINavigationController!
    var cartNavigation: UINavigationController!
    var profileNavigation: UINavigationController!

    var tabs: [UIViewController] {
        return [
            catalogNavigation,
            cartNavigation,
            profileNavigation
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        modalTransitionStyle = .crossDissolve
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        apply(theme: theme)
        presenter.shouldViewAppear()
    }

    func setupTabs() {
        let catalogTabBarItem = UITabBarItem(
            title: "Catalog",
            image: UIImage(named: "catalog-icon"),
            tag: 0
        )
        catalogNavigation.tabBarItem = catalogTabBarItem

        let cartTabBarItem = UITabBarItem(
            title: "Cart",
            image: UIImage(named: "cart-tab-icon"),
            tag: 1
        )
        cartNavigation.tabBarItem = cartTabBarItem

        let profileTabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "profile-icon"),
            tag: 2
        )
        profileNavigation.tabBarItem = profileTabBarItem

        viewControllers = tabs
    }

    private func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        tabBar.tintColor = theme.tintColor
        tabBar.barTintColor = theme.barColor
    }
}

// MARK: - DashboardView implementation
extension DashboardViewImpl: DashboardView { }

// MARK: - ThemeUpdatable implementation
extension DashboardViewImpl: ThemeUpdatable {
    func update(theme: Theme, animated: Bool) {
        self.theme = theme

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

        animation?.run(completion: nil)
    }
}

// MARK: - DashboardShow implementation
extension DashboardViewImpl: DashboardShow {
    var tabController: UITabBarController {
        return self
    }
}

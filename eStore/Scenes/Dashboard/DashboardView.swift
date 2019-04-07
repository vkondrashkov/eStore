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
        view.backgroundColor = .white
        tabBar.tintColor = Color.shamrock
        tabBar.barTintColor = Color.navigationBar
        modalTransitionStyle = .crossDissolve
    }

    func setupTabs() {
        let catalogTabBarItem = UITabBarItem(
            title: "Catalog",
            image: UIImage(named: "catalog-icon"),
            tag: 0
        )
        catalogNavigation.tabBarItem = catalogTabBarItem

        let cartTabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        cartNavigation.tabBarItem = cartTabBarItem

        let profileTabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "profile-icon"),
            tag: 1
        )
        profileNavigation.tabBarItem = profileTabBarItem

        viewControllers = tabs
    }
}

// MARK: - DashboardView implementation
extension DashboardViewImpl: DashboardView { }

// MARK: - DashboardShow implementation
extension DashboardViewImpl: DashboardShow {
    var tabController: UITabBarController {
        return self
    }
}

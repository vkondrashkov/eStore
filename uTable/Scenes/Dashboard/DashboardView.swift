//
//  DashboardView.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DashboardViewImpl: UITabBarController {
    var presenter: DashboardPresenter!

    var feedNavigation: UINavigationController!
    var profileNavigation: UINavigationController!

    var tabs: [UIViewController] {
        return [
            feedNavigation,
            profileNavigation
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        feedNavigation = UINavigationController()
        feedNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)

        profileNavigation = UINavigationController()
        profileNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)

        viewControllers = tabs
        // presenter.handleLoadView() // Crash?
    }
}

// MARK: - RootView implementation
extension DashboardViewImpl: DashboardView { }

// MARK: - RootShow implementation
extension DashboardViewImpl: DashboardShow {
    var tabController: UITabBarController {
        return self
    }
}

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

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        modalTransitionStyle = .crossDissolve
    }

    func setupTabs() {
        feedNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        profileNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)

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

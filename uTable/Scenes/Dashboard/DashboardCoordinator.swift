//
//  DashboardCoordinator.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class DashboardCoordinator {
    private let navigation: UITabBarController
    private let view: DashboardViewController

    // TimeTableBuilder
    // TimeTableCoordinator

    // ProfileBuilder
    // ProfileCoordinator
    // TODO: Add TimeTable and Profile builders to initializer

    init(navigation: UITabBarController,
         view: DashboardViewController) {
        self.navigation = navigation
        self.view = view
    }
}

// MARK: - Coordinator implementation
extension DashboardCoordinator: Coordinator {
    func start() {
        let timeTableNavigation = UINavigationController()
        // Build coordinator
        timeTableNavigation.view.backgroundColor = .red
        timeTableNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0) // Temp

        let profileNavigation = UINavigationController()
        // Build coordinator
        profileNavigation.view.backgroundColor = .green
        profileNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1) // Temp

        navigation.viewControllers = [timeTableNavigation, profileNavigation]
    }
}


// MARK: - DashboardRouter implementation
extension DashboardCoordinator: DashboardRouter {
    func routeTimeTable() {

    }

    func routeProfile() {

    }
}

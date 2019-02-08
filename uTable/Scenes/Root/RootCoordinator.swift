//
//  RootCoordinator.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class RootCoordinator {
    private let window: UIWindow
    private let navigation: UITabBarController

    private var dashboardCoordinator: DashboardCoordinator?
    private let dashboardBuilder: DashboardBuilder

    init(window: UIWindow,
         navigation: UITabBarController,
         dashboardBuilder: DashboardBuilder) {
        self.window = window
        self.navigation = navigation
        self.dashboardBuilder = dashboardBuilder
    }
}

// MARK: - Coordinator implementation
extension RootCoordinator: Coordinator {
    func start() {
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        dashboardCoordinator = dashboardBuilder.build()
        dashboardCoordinator?.start()
    }
}

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
    private let navigation: UINavigationController

    // DashboardCoordinator
    // DashboardBuilder

    // TODO: Add Dashboard builder,
    // component to initializer
    init(window: UIWindow,
         navigation: UINavigationController) {
        self.window = window
        self.navigation = navigation
    }
}

// MARK: - Coordinator implementation
extension RootCoordinator: Coordinator {
    func start() {
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        // Build DashboardCoordinator
        // Start DashboardCoordinator
    }
}

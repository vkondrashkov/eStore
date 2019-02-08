//
//  RootBuilder.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol RootDependency: Dependency {
    var window: UIWindow { get }
}

class RootComponent: Component<RootDependency> {
    let rootViewController: UITabBarController

    var window: UIWindow {
        return dependency.window
    }

    init(dependency: RootDependency,
         rootViewController: UITabBarController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

protocol RootBuildable {
    func build() -> RootCoordinator
}

class RootBuilder: Builder<RootDependency>, RootBuildable {
    func build() -> RootCoordinator {
        let rootViewController = UITabBarController()
        let component = RootComponent(
            dependency: dependency,
            rootViewController: rootViewController
        )
        let dashboardBuilder = DashboardBuilder(dependency: component)
        let coordinator = RootCoordinator(
            window: component.window,
            navigation: component.rootViewController,
            dashboardBuilder: dashboardBuilder
        )
        return coordinator
    }
}

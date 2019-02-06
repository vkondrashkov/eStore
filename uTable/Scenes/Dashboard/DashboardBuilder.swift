//
//  DashboardBuilder.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol DashboardDependency: Dependency {
    var navigation: UINavigationController { get }
}

final class DashboardComponent: Component<DashboardDependency> {
    var navigation: UINavigationController {
        return dependency.navigation
    }
    // Services
    // TODO: Add services to initializer
    override init(dependency: DashboardDependency) {
        super.init(dependency: dependency)
    }
}

protocol DashboardBuildable {
    func build() -> DashboardCoordinator
}

class DashboardBuilder: Builder<DashboardDependency>, DashboardBuildable {
    func build() -> DashboardCoordinator {
        let component = DashboardComponent(dependency: dependency)

        // TimeTable Builder
        // Profile Builder

        let view = DashboardViewController()
        let presenter = DashboardPresenterImpl(view: view)

        view.presenter = presenter
        let coordinator = DashboardCoordinator(
            navigation: component.navigation,
            view: view
        )
        presenter.router = coordinator
        return coordinator
    }
}


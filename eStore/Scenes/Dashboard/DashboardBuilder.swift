//
//  DashboardBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DashboardBuilderImpl {
    private let dependency: DashboardDependency

    init(dependency: DashboardDependency) {
        self.dependency = dependency
    }
}

// MARK: - DashboardBuilder implementation
extension DashboardBuilderImpl: DashboardBuilder {
    func build(with listener: DashboardListener) -> DashboardCoordinator {
        let catalogNavigation = UINavigationController()
        let profileNavigation = UINavigationController()
        let view = DashboardViewImpl()
        view.catalogNavigation = catalogNavigation
        view.profileNavigation = profileNavigation
        view.setupTabs()
        let component = DashboardComponent(rootViewController: view,
                                           catalogNavigation: catalogNavigation,
                                           profileNavigation: profileNavigation)
        let scene = DashboardSceneImpl(rootViewController: dependency.parent)
        let profileBuilder = ProfileBuilderImpl(dependency: component)
        let catalogBuilder = CatalogBuilderImpl(dependency: component)
        let coordinator = DashboardCoordinator(scene: scene,
                                               show: view,
                                               profileBuilder: profileBuilder,
                                               catalogBuilder: catalogBuilder,
                                               listener: listener)
        let presenter = DashboardPresenterImpl(view: view,
                                               router: coordinator)
        view.presenter = presenter
        return coordinator
    }
}

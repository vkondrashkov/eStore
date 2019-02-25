//
//  RootBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootBuilderImpl {
    private let dependency: RootDependency

    init(dependency: RootDependency) {
        self.dependency = dependency
    }
}

// MARK: - RootBuilder implementation
extension RootBuilderImpl: RootBuilder {
    func build() -> RootCoordinator {
        let view = RootViewImpl()
        let component = RootComponent(rootViewController: view)
        let scene = RootSceneImpl(window: dependency.parent)
        let authBuilder = AuthBuilderImpl(dependency: component)
        let dashboardBuilder = DashboardBuilderImpl(dependency: component)
        let coordinator = RootCoordinator(scene: scene,
                                          show: view,
                                          dashboardBuilder: dashboardBuilder,
                                          authBuilder: authBuilder)
        let presenter = RootPresenterImpl(view: view,
                                          router: coordinator)
        view.presenter = presenter
        return coordinator
    }
}

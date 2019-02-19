//
//  DashboardBuilder.swift
//  uTable
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
    func build() -> DashboardCoordinator {
        let view = DashboardViewImpl()
        let component = DashboardComponent(rootViewController: view)
        let scene = DashboardSceneImpl(rootViewController: dependency.parent)
        // ProfileBuilder
        // FeedBuilder
        let coordinator = DashboardCoordinator(scene: scene,
                                               show: view)
        let presenter = DashboardPresenterImpl(view: view,
                                               router: coordinator)
        view.presenter = presenter
        return coordinator
    }
}

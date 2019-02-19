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
    func build(with listener: DashboardListener) -> DashboardCoordinator {
        let feedNavigation = UINavigationController()
        let profileNavigation = UINavigationController()
        let view = DashboardViewImpl()
        view.feedNavigation = feedNavigation
        view.profileNavigation = profileNavigation
        view.setupTabs()
        let component = DashboardComponent(rootViewController: view,
                                           feedNavigation: feedNavigation,
                                           profileNavigation: profileNavigation)
        let scene = DashboardSceneImpl(rootViewController: dependency.parent)
        let profileBuilder = ProfileBuilderImpl(dependency: component)
        // FeedBuilder
        let coordinator = DashboardCoordinator(scene: scene,
                                               show: view,
                                               profileBuilder: profileBuilder,
                                               listener: listener)
        let presenter = DashboardPresenterImpl(view: view,
                                               router: coordinator)
        view.presenter = presenter
        return coordinator
    }
}

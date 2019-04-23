//
//  ProfileBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileBuilderImpl {
    private let dependency: ProfileDependency

    init(dependency: ProfileDependency) {
        self.dependency = dependency
    }
}

// MARK: - ProfileBuilder implementation
extension ProfileBuilderImpl: ProfileBuilder {
    func build(with listener: ProfileListener) -> ProfileCoordinator {
        let view = ProfileViewImpl()
        view.alertFactory = dependency.alertFactory
        view.theme = dependency.themeManager.currentTheme
        let component = ProfileComponent(
            navigation: dependency.profileNavigation,
            themeManager: dependency.themeManager,
            alertFactory: dependency.alertFactory
        )
        let themeSettingsBuilder = ThemeSettingsBuilderImpl(dependency: component)
        let scene = ProfileSceneImpl(rootViewController: dependency.profileNavigation)
        let coordinator = ProfileCoordinator(
            scene: scene,
            show: view,
            themeSettingsBuilder: themeSettingsBuilder,
            listener: listener
        )
        let presenter = ProfilePresenterImpl(
            view: view,
            router: coordinator,
            themeManager: dependency.themeManager
        )
        view.presenter = presenter
        return coordinator
    }
}

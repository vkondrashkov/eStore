//
//  ThemeBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/7/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ThemeSettingsBuilderImpl {
    private let dependency: ThemeSettingsDependency

    init(dependency: ThemeSettingsDependency) {
        self.dependency = dependency
    }
}

// MARK: - ThemeSettingsBuilder implementation
extension ThemeSettingsBuilderImpl: ThemeSettingsBuilder {
    func build() -> ThemeSettingsCoordinator {
        let view = ThemeSettingsViewImpl()
        view.alertFactory = dependency.alertFactory
        view.theme = dependency.themeManager.currentTheme
        let scene = ThemeSettingsSceneImpl(navigation: dependency.navigation)
        let coordinator = ThemeSettingsCoordinator(
            scene: scene,
            show: view
        )
        let presenter = ThemeSettingsPresenterImpl(
            view: view,
            themeManager: dependency.themeManager
        )
        view.presenter = presenter
        return coordinator
    }
}

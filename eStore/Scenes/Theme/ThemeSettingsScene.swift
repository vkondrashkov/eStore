//
//  ThemeScene.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/7/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ThemeSettingsSceneImpl {
    let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

// MARK: - ThemeSettingsScene implementation
extension ThemeSettingsSceneImpl: ThemeSettingsScene {
    func play(themeSettingsShow: ThemeSettingsShow) {
        navigation.pushViewController(themeSettingsShow.viewController, animated: true)
    }
}

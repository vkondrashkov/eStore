//
//  ProfileComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileComponent {
    let navigation: UINavigationController
    let themeManager: ThemeManager

    init(navigation: UINavigationController,
         themeManager: ThemeManager) {

        self.navigation = navigation
        self.themeManager = themeManager
    }
}

// MARK: - ThemeSettingsDependency implementation
extension ProfileComponent: ThemeSettingsDependency { }

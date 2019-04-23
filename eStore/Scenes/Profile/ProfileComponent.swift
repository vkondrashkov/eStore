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
    let alertFactory: AlertFactory

    init(navigation: UINavigationController,
         themeManager: ThemeManager,
         alertFactory: AlertFactory) {

        self.navigation = navigation
        self.themeManager = themeManager
        self.alertFactory = alertFactory
    }
}

// MARK: - ThemeSettingsDependency implementation
extension ProfileComponent: ThemeSettingsDependency { }

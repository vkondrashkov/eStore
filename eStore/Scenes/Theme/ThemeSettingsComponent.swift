//
//  ThemeComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/7/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ThemeSettingsComponent {
    let navigation: UINavigationController
    let themeManager: ThemeManager

    init(navigation: UINavigationController,
         themeManager: ThemeManager) {

        self.navigation = navigation
        self.themeManager = themeManager
    }
}


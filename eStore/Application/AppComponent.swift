//
//  AppComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class AppComponent {
    let window: UIWindow
    let themeManager: ThemeManager

    init(window: UIWindow,
         themeManager: ThemeManager) {

        self.window = window
        self.themeManager = themeManager
    }
}

// MARK: - RootDependency implementation
extension AppComponent: RootDependency {
    var parent: UIWindow {
        return window
    }
}

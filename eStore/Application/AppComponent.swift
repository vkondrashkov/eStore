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
    let authorizationRepository: AuthorizationRepository
    let userRepository: UserRepository
    let themeManager: ThemeManager
    let alertFactory: AlertFactory

    init(window: UIWindow,
         authorizationRepository: AuthorizationRepository,
         userRepository: UserRepository,
         themeManager: ThemeManager,
         alertFactory: AlertFactory) {

        self.window = window
        self.authorizationRepository = authorizationRepository
        self.userRepository = userRepository
        self.themeManager = themeManager
        self.alertFactory = alertFactory
    }
}

// MARK: - RootDependency implementation
extension AppComponent: RootDependency {
    var parent: UIWindow {
        return window
    }
}

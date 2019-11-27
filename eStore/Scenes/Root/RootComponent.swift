//
//  RootComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootComponent {
    let rootViewController: UIViewController
    let authorizationRepository: AuthorizationRepository
    let userRepository: UserRepository
    let themeManager: ThemeManager
    let userMapper: UserMapper
    let alertFactory: AlertFactory

    init(rootViewController: UIViewController,
         authorizationRepository: AuthorizationRepository,
         userRepository: UserRepository,
         themeManager: ThemeManager,
         userMapper: UserMapper,
         alertFactory: AlertFactory) {
        self.rootViewController = rootViewController
        self.authorizationRepository = authorizationRepository
        self.userRepository = userRepository
        self.themeManager = themeManager
        self.userMapper = userMapper
        self.alertFactory = alertFactory
    }
}

// MARK: - DashboardDependency implementation
// MARK: - AuthDependency implementation
extension RootComponent: DashboardDependency, AuthDependency {
    var parent: UIViewController {
        return rootViewController
    }
}

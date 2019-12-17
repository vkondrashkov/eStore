//
//  DashboardComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DashboardComponent: CatalogDependency, CartDependency, ProfileDependency {
    let rootViewController: UITabBarController
    let catalogNavigation: UINavigationController
    let cartNavigation: UINavigationController
    let profileNavigation: UINavigationController
    let userRepository: UserRepository
    let cartRepository: CartRepository
    let themeManager: ThemeManager
    let alertFactory: AlertFactory

    init(rootViewController: UITabBarController,
         catalogNavigation: UINavigationController,
         cartNavigation: UINavigationController,
         profileNavigation: UINavigationController,
         userRepository: UserRepository,
         cartRepository: CartRepository,
         themeManager: ThemeManager,
         alertFactory: AlertFactory) {
        self.rootViewController = rootViewController
        self.catalogNavigation = catalogNavigation
        self.cartNavigation = cartNavigation
        self.profileNavigation = profileNavigation
        self.userRepository = userRepository
        self.cartRepository = cartRepository
        self.themeManager = themeManager
        self.alertFactory = alertFactory
    }
}

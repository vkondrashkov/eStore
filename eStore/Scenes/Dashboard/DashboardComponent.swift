//
//  DashboardComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DashboardComponent {
    let rootViewController: UITabBarController
    let catalogNavigation: UINavigationController
    let cartNavigation: UINavigationController
    let profileNavigation: UINavigationController
    let themeManager: ThemeManager

    init(rootViewController: UITabBarController,
         catalogNavigation: UINavigationController,
         cartNavigation: UINavigationController,
         profileNavigation: UINavigationController,
         themeManager: ThemeManager) {

        self.rootViewController = rootViewController
        self.catalogNavigation = catalogNavigation
        self.cartNavigation = cartNavigation
        self.profileNavigation = profileNavigation
        self.themeManager = themeManager
    }
}

// MARK: - ProfileDependency implementation
extension DashboardComponent: ProfileDependency { }

// MARK: - CartDependency implementation
extension DashboardComponent: CartDependency { }

// MARK: - CatalogDependency implementation
extension DashboardComponent: CatalogDependency { }

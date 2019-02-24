//
//  DashboardComponent.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DashboardComponent {
    let rootViewController: UITabBarController
    let catalogNavigation: UINavigationController
    let profileNavigation: UINavigationController

    init(rootViewController: UITabBarController,
         catalogNavigation: UINavigationController,
         profileNavigation: UINavigationController) {

        self.rootViewController = rootViewController
        self.catalogNavigation = catalogNavigation
        self.profileNavigation = profileNavigation
    }
}

// MARK: - ProfileDependency implementation
extension DashboardComponent: ProfileDependency { }

// MARK: - CatalogDependency implementation
extension DashboardComponent: CatalogDependency { }

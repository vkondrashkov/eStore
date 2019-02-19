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
    let feedNavigation: UINavigationController
    let profileNavigation: UINavigationController

    init(rootViewController: UITabBarController,
         feedNavigation: UINavigationController,
         profileNavigation: UINavigationController) {

        self.rootViewController = rootViewController
        self.feedNavigation = feedNavigation
        self.profileNavigation = profileNavigation
    }
}

// MARK: - ProfileDependency implementation
extension DashboardComponent: ProfileDependency { }

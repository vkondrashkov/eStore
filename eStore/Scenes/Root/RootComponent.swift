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
    let themeManager: ThemeManager

    init(rootViewController: UIViewController,
         themeManager: ThemeManager) {

        self.rootViewController = rootViewController
        self.themeManager = themeManager
    }
}

// MARK: - DashboardDependency implementation
// MARK: - AuthDependency implementation
extension RootComponent: DashboardDependency, AuthDependency {
    var parent: UIViewController {
        return rootViewController
    }
}

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
    let alertFactory: AlertFactory

    init(rootViewController: UIViewController,
         themeManager: ThemeManager,
         alertFactory: AlertFactory) {

        self.rootViewController = rootViewController
        self.themeManager = themeManager
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

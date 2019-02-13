//
//  RootComponent.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootComponent {
    let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
}

// MARK: - DashboardDependency implementation
extension RootComponent: DashboardDependency {
    var parent: UINavigationController {
        return rootViewController
    }
}

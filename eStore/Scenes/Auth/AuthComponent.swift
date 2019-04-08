//
//  AuthComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class AuthComponent {
    let rootViewController: UINavigationController
    let themeManager: ThemeManager

    init(rootViewController: UINavigationController,
         themeManager: ThemeManager) {

        self.rootViewController = rootViewController
        self.themeManager = themeManager
    }
}

// MARK: - SignUpDependency implementation
extension AuthComponent: SignUpDependency, SignInDependency {
    var parent: UINavigationController {
        return rootViewController
    }
}

//
//  AuthComponent.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class AuthComponent {
    let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
}

// MARK: - SignUpDependency implementation
extension AuthComponent: SignUpDependency {
    var parent: UINavigationController {
        return rootViewController
    }
}

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
    let credentialsValidatorUseCase: CredentialsValidatorUseCase
    let authorizationUseCase: AuthorizationUseCase
    let alertFactory: AlertFactory

    init(rootViewController: UINavigationController,
         themeManager: ThemeManager,
         credentialsValidatorUseCase: CredentialsValidatorUseCase,
         authorizationUseCase: AuthorizationUseCase,
         alertFactory: AlertFactory) {

        self.rootViewController = rootViewController
        self.themeManager = themeManager
        self.credentialsValidatorUseCase = credentialsValidatorUseCase
        self.authorizationUseCase = authorizationUseCase
        self.alertFactory = alertFactory
    }
}

// MARK: - SignUpDependency implementation
extension AuthComponent: SignUpDependency, SignInDependency {
    var parent: UINavigationController {
        return rootViewController
    }
}

//
//  AuthBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class AuthBuilderImpl {
    private let dependency: AuthDependency

    init(dependency: AuthDependency) {
        self.dependency = dependency
    }
}

// MARK: - AuthBuilder implementation
extension AuthBuilderImpl: AuthBuilder {
    func build(with listener: AuthListener) -> AuthCoordinator {
        let view = AuthViewImpl()
        view.theme = dependency.themeManager.currentTheme
        let component = AuthComponent(
            rootViewController: view,
            themeManager: dependency.themeManager,
            credentialsValidatorUseCase: CredentialsValidatorUseCaseImpl(),
            authorizationUseCase: AuthorizationUseCaseImpl(
                authorizationRepository: dependency.authorizationRepository,
                userRepository: dependency.userRepository,
                userMapper: dependency.userMapper
            ),
            alertFactory: dependency.alertFactory
        )
        let scene = AuthSceneImpl(rootViewController: dependency.parent)
        let signUpBuilder = SignUpBuilderImpl(dependency: component)
        let signInBuilder = SignInBuilderImpl(dependency: component)
        let coordinator = AuthCoordinator(scene: scene,
                                          show: view,
                                          signUpBuilder: signUpBuilder,
                                          signInBuilder: signInBuilder,
                                          listener: listener)
        let presenter = AuthPresenterImpl(
            view: view,
            router: coordinator,
            themeManager: dependency.themeManager
        )
        view.presenter = presenter
        return coordinator
    }
}

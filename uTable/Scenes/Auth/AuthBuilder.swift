//
//  AuthBuilder.swift
//  uTable
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
        let component = AuthComponent(rootViewController: view)
        let scene = AuthSceneImpl(rootViewController: dependency.parent)
        // SignUpBuilder
        // SignInBuilder
        let coordinator = AuthCoordinator(scene: scene,
                                          show: view)
        let presenter = AuthPresenterImpl(view: view,
                                          router: coordinator)
        view.presenter = presenter
        return coordinator
    }
}

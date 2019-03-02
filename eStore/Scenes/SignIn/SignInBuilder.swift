//
//  SignInBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/15/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignInBuilderImpl {
    private let dependency: SignInDependency

    init(dependency: SignInDependency) {
        self.dependency = dependency
    }
}

// MARK: - SignInBuilder implementation
extension SignInBuilderImpl: SignInBuilder {
    func build(with listener: SignInListener) -> SignInCoordinator {
        let view = SignInViewImpl()
        let scene = SignInSceneImpl(navViewController: dependency.parent)
        let coordinator = SignInCoordinator(scene: scene,
                                            show: view,
                                            listener: listener)
        let presenter = SignInPresenterImpl(view: view,
                                            router: coordinator)
        view.presenter = presenter
        return coordinator
    }
}

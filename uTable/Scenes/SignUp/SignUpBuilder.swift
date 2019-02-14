//
//  SignUpBuilder.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignUpBuilderImpl {
    private let dependency: SignUpDependency

    init(dependency: SignUpDependency) {
        self.dependency = dependency
    }
}

// MARK: - SignUpBuilder implementation
extension SignUpBuilderImpl: SignUpBuilder {
    func build(with listener: SignUpListener) -> SignUpCoordinator {
        let view = SignUpViewImpl()
        let scene = SignUpSceneImpl(navViewController: dependency.parent)
        let coordinator = SignUpCoordinator(scene: scene,
                                            show: view)
        let presenter = SignUpPresenterImpl(view: view,
                                            listener: listener)
        view.presenter = presenter
        return coordinator
    }
}

//
//  CartBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import Moya

final class CartBuilderImpl {
    private let dependency: CartDependency

    init(dependency: CartDependency) {
        self.dependency = dependency
    }
}

// MARK: - CartBuilder implementation
extension CartBuilderImpl: CartBuilder {
    func build() -> CartCoordinator {
        let view = CartViewImpl()
        view.alertFactory = dependency.alertFactory
        view.theme = dependency.themeManager.currentTheme
        let scene = CartSceneImpl(navigation: dependency.cartNavigation)
        let coordinator = CartCoordinator(scene: scene,
                                          show: view)
        let presenter = CartPresenterImpl(
            view: view,
            router: coordinator,
            interactor: CartInteractorImpl(
                cartRepository: CartRepositoryImpl(
                    provider: MoyaProvider<eStoreAPI>()
                )
            ),
            themeManager: dependency.themeManager
        )
        view.presenter = presenter
        return coordinator
    }
}

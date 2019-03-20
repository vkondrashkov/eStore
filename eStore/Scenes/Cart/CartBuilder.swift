//
//  CartBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

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
        let component = CartComponent(navigation: dependency.navigation)
        let scene = CartSceneImpl(navigation: dependency.navigation)
        let coordinator = CartCoordinator(scene: scene,
                                          show: view)
        let presenter = CartPresenterImpl(view: view,
                                          router: coordinator)
        view.presenter = presenter
        return coordinator
    }
}

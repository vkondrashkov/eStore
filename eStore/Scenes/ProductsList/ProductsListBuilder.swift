//
//  ProductsListBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductsListBuilderImpl {
    private let dependency: ProductsListDependency

    init(dependency: ProductsListDependency) {
        self.dependency = dependency
    }
}

// MARK: - ProductsListBuilder implementation
extension ProductsListBuilderImpl: ProductsListBuilder {
    func build(with productType: ProductType) -> ProductsListCoordinator {
        let view = ProductsListViewImpl()
        view.title = productType.rawValue
        let component = ProductsListComponent(
            navigation: dependency.navigation,
            themeManager: dependency.themeManager
        )
        let scene = ProductsListSceneImpl(navigation: dependency.navigation)
        let productDescriptionBuilder = ProductDescriptionBuilderImpl(dependency: component)
        let coordinator = ProductsListCoordinator(scene: scene,
                                                  show: view,
                                                  productDescriptionBuilder: productDescriptionBuilder)
        let presenter = ProductsListPresenterImpl(view: view,
                                                  router: coordinator,
                                                  productType: productType)
        view.presenter = presenter
        return coordinator
    }
}

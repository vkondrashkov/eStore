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
        view.theme = dependency.themeManager.currentTheme
        let component = ProductsListComponent(
            navigation: dependency.navigation,
            themeManager: dependency.themeManager,
            alertFactory: dependency.alertFactory
        )
        let scene = ProductsListSceneImpl(navigation: dependency.navigation)
        let productDescriptionBuilder = ProductDescriptionBuilderImpl(dependency: component)
        let coordinator = ProductsListCoordinator(
            scene: scene,
            show: view,
            productDescriptionBuilder: productDescriptionBuilder
        )
        let presenter = ProductsListPresenterImpl(
            view: view,
            router: coordinator,
            interactor: ProductsListInteractorImpl(
                productsUseCase: dependency.productsUseCase
            ),
            productsService: dependency.productsService,
            productType: productType,
            themeManager: dependency.themeManager
        )
        view.presenter = presenter
        return coordinator
    }
}

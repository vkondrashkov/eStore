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
        view.title = productType.title
        view.theme = dependency.themeManager.currentTheme
        let component = ProductsListComponent(
            navigation: dependency.navigation,
            smartphoneEditorScene: SmartphoneEditorSceneImpl(navigation: dependency.navigation),
            laptopEditorScene: LaptopEditorSceneImpl(navigation: dependency.navigation),
            userRepository: dependency.userRepository,
            cartRepository: dependency.cartRepository,
            productsUseCase: dependency.productsUseCase,
            themeManager: dependency.themeManager,
            alertFactory: dependency.alertFactory
        )
        let scene = ProductsListSceneImpl(navigation: dependency.navigation)
        let productDescriptionBuilder = ProductDescriptionBuilderImpl(dependency: component)
        let smartphoneEditorBuilder = SmartphoneEditorBuilderImpl(dependency: component)
        let laptopEditorBuilder = LaptopEditorBuilderImpl(dependency: component)
        let coordinator = ProductsListCoordinator(
            scene: scene,
            show: view,
            productDescriptionBuilder: productDescriptionBuilder,
            smartphoneEditorBuilder: smartphoneEditorBuilder,
            laptopEditorBuilder: laptopEditorBuilder
        )
        let presenter = ProductsListPresenterImpl(
            view: view,
            router: coordinator,
            interactor: ProductsListInteractorImpl(
                productsUseCase: dependency.productsUseCase,
                userRepository: dependency.userRepository,
                cartRepository: dependency.cartRepository
            ),
            productType: productType,
            themeManager: dependency.themeManager
        )
        view.presenter = presenter
        return coordinator
    }
}

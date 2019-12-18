//
//  ProductDescriptionBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductDescriptionBuilderImpl {
    private let dependency: ProductDescriptionDependency
    
    init(dependency: ProductDescriptionDependency) {
        self.dependency = dependency
    }
}

// MARK: - ProductDescriptionBuilder implementation
extension ProductDescriptionBuilderImpl: ProductDescriptionBuilder {
    func build(with storeItem: StoreItem) -> ProductDescriptionCoordinator {
        let dataSource = ProductDescriptionTableViewDataSource()
        dataSource.item = storeItem
        let view = ProductDescriptionViewImpl()
        dataSource.delegate = view
        view.dataSource = dataSource
        view.alertFactory = dependency.alertFactory
        view.theme = dependency.themeManager.currentTheme
        let scene = ProductDescriptionSceneImpl(navigation: dependency.navigation)
        let component = ProductDescriptionComponent(
            navigation: dependency.navigation,
            smartphoneEditorScene: SmartphoneEditorSceneImpl(navigation: dependency.navigation),
            laptopEditorScene: LaptopEditorSceneImpl(navigation: dependency.navigation),
            tvEditorScene: TVEditorSceneImpl(navigation: dependency.navigation),
            userRepository: dependency.userRepository,
            productsUseCase: dependency.productsUseCase,
            themeManager: dependency.themeManager,
            alertFactory: dependency.alertFactory
        )
        let smartphoneEditorBuilder = SmartphoneEditorBuilderImpl(dependency: component)
        let laptopEditorBuilder = LaptopEditorBuilderImpl(dependency: component)
        let tvEditorBuilder = TVEditorBuilderImpl(dependency: component)
        let coordinator = ProductDescriptionCoordinator(
            scene: scene,
            show: view,
            smartphoneEditorBuilder: smartphoneEditorBuilder,
            laptopEditorBuilder: laptopEditorBuilder,
            tvEditorBuilder: tvEditorBuilder
        )
        let presenter = ProductDescriptionPresenterImpl(
            view: view,
            router: coordinator,
            interactor: ProductDescriptionInteractorImpl(
                cartRepository: dependency.cartRepository,
                userRepository: dependency.userRepository,
                productsUseCase: dependency.productsUseCase
            ),
            themeManager: dependency.themeManager
        )
        view.presenter = presenter
        return coordinator
    }
}

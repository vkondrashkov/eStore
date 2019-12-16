//
//  CatalogBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import Moya

final class CatalogBuilderImpl {
    private let dependency: CatalogDependency
    
    init(dependency: CatalogDependency) {
        self.dependency = dependency
    }
}

// MARK: - CatalogBuilder implementation
extension CatalogBuilderImpl: CatalogBuilder {
    func build() -> CatalogCoordinator {
        let view = CatalogViewImpl()
        view.theme = dependency.themeManager.currentTheme
        let component = CatalogComponent(
            navigation: dependency.catalogNavigation,
            productsUseCase: ProductsUseCaseImpl(
                repository: ProductsRepositoryImpl(provider: MoyaProvider<eStoreAPI>(stubClosure: MoyaProvider.immediatelyStub))
            ),
            productsService: ProductsServiceImpl(),
            themeManager: dependency.themeManager,
            alertFactory: dependency.alertFactory
        )
        let scene = CatalogSceneImpl(rootViewController: dependency.catalogNavigation)
        let productsListBuilder = ProductsListBuilderImpl(dependency: component)
        let coordinator = CatalogCoordinator(scene: scene,
                                             show: view,
                                             productsListBuilder: productsListBuilder)
        let presenter = CatalogPresenterImpl(
            view: view,
            router: coordinator,
            themeManager: dependency.themeManager
        )
        view.presenter = presenter
        return coordinator
    }
}

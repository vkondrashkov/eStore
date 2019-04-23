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
        view.dataSource = dataSource
        view.theme = dependency.themeManager.currentTheme
        let scene = ProductDescriptionSceneImpl(navigation: dependency.navigation)
        let coordinator = ProductDescriptionCoordinator(scene: scene,
                                                        show: view)
        let presenter = ProductDescriptionPresenterImpl(
            view: view,
            themeManager: dependency.themeManager
        )
        view.presenter = presenter
        return coordinator
    }
}

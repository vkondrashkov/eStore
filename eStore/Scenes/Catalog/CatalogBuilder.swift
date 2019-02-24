//
//  CatalogBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

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
        let component = CatalogComponent(rootViewController: view)
        let scene = CatalogSceneImpl(rootViewController: dependency.catalogNavigation)
        let coordinator = CatalogCoordinator(scene: scene,
                                             show: view)
        let presenter = CatalogPresenterImpl(view: view,
                                             router: coordinator)
        view.presenter = presenter
        return coordinator
    }
}

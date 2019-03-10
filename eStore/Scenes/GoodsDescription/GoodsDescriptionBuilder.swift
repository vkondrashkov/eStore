//
//  GoodsDescriptionBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class GoodsDescriptionBuilderImpl {
    private let dependency: GoodsDescriptionDependency

    init(dependency: GoodsDescriptionDependency) {
        self.dependency = dependency
    }
}

// MARK: - GoodsDescriptionBuilder implementation
extension GoodsDescriptionBuilderImpl: GoodsDescriptionBuilder {
    func build(with storeItem: StoreItem) -> GoodsDescriptionCoordinator {
        let dataSource = GoodsDescriptionTableViewDataSource()
        dataSource.item = storeItem
        let view = GoodsDescriptionViewImpl()
        view.title = storeItem.name
        view.dataSource = dataSource
        let scene = GoodsDescriptionSceneImpl(navigation: dependency.navigation)
        let coordinator = GoodsDescriptionCoordinator(scene: scene,
                                                      show: view)
        let presenter = GoodsDescriptionPresenterImpl(view: view)
        view.presenter = presenter
        return coordinator
    }
}

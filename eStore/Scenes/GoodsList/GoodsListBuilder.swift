//
//  GoodsListBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class GoodsListBuilderImpl {
    private let dependency: GoodsListDependency

    init(dependency: GoodsListDependency) {
        self.dependency = dependency
    }
}

// MARK: - GoodsListBuilder implementation
extension GoodsListBuilderImpl: GoodsListBuilder {
    func build(with productType: ProductType) -> GoodsListCoordinator {
        let view = GoodsListViewImpl()
        view.title = productType.rawValue
        let component = GoodsListComponent(navigation: dependency.navigation)
        let scene = GoodsListSceneImpl(navigation: dependency.navigation)
        let goodsDescriptionBuilder = GoodsDescriptionBuilderImpl(dependency: component)
        let coordinator = GoodsListCoordinator(scene: scene,
                                               show: view,
                                               goodsDescriptionBuilder: goodsDescriptionBuilder)
        let presenter = GoodsListPresenterImpl(view: view,
                                               router: coordinator,
                                               productType: productType)
        view.presenter = presenter
        return coordinator
    }
}

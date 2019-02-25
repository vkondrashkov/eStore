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
    func build(title: String) -> GoodsListCoordinator {
        let view = GoodsListViewImpl()
        view.title = title
        let scene = GoodsListSceneImpl(navigation: dependency.navigation)
        let coordinator = GoodsListCoordinator(scene: scene,
                                               show: view)
        let presenter = GoodsListPresenterImpl(view: view)
        view.presenter = presenter
        return coordinator
    }
}

//
//  CatalogCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class CatalogCoordinator {
    private let scene: CatalogScene
    private let show: CatalogShow

    private let goodsListBuilder: GoodsListBuilder
    private var goodsListCoordinator: GoodsListCoordinator?

    init(scene: CatalogScene,
         show: CatalogShow,
         goodsListBuilder: GoodsListBuilder) {

        self.scene = scene
        self.show = show
        self.goodsListBuilder = goodsListBuilder
    }
}

// MARK: - Coordinator implementation
extension CatalogCoordinator: Coordinator {
    func start() {
        scene.play(catalogShow: show)
    }

    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

// MARK: - ProfileRouter implementation
extension CatalogCoordinator: CatalogRouter { }

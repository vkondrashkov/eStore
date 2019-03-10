//
//  GoodsListCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class GoodsListCoordinator {
    private let scene: GoodsListScene
    private let show: GoodsListShow

    private let goodsDescriptionBuilder: GoodsDescriptionBuilder
    private var goodsDescriptionCoordinator: GoodsDescriptionCoordinator?

    init(scene: GoodsListScene,
         show: GoodsListShow,
         goodsDescriptionBuilder: GoodsDescriptionBuilder) {

        self.scene = scene
        self.show = show
        self.goodsDescriptionBuilder = goodsDescriptionBuilder
    }
}

// MARK: - Coordinator implementation
extension GoodsListCoordinator: Coordinator {
    func start() {
        scene.play(goodsListShow: show)
    }

    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

// MARK: - GoodsListRouter implementation
extension GoodsListCoordinator: GoodsListRouter {
    func showGoodsDescription(for storeItem: StoreItem) {
        let dataSource = GoodsDescriptionTableViewDataSource()
        dataSource.item = storeItem
        goodsDescriptionCoordinator = goodsDescriptionBuilder.build(with: dataSource)
        goodsDescriptionCoordinator?.start()
    }
}

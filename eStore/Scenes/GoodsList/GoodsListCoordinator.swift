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

    init(scene: GoodsListScene,
         show: GoodsListShow) {
        self.scene = scene
        self.show = show
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

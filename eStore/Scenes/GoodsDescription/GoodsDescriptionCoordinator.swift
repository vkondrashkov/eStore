//
//  GoodsDescriptionCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class GoodsDescriptionCoordinator {
    private let scene: GoodsDescriptionScene
    private let show: GoodsDescriptionShow

    init(scene: GoodsDescriptionScene,
         show: GoodsDescriptionShow) {
        self.scene = scene
        self.show = show
    }
}

// MARK: - Coordinator implementation
extension GoodsDescriptionCoordinator: Coordinator {
    func start() {
        scene.play(goodsDescriptionShow: show)
    }

    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

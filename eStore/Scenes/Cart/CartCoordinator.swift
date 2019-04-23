//
//  CartCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class CartCoordinator {
    private let scene: CartScene
    private let show: CartShow

    init(scene: CartScene,
         show: CartShow) {

        self.scene = scene
        self.show = show
    }
}

// MARK: - Coordinator implementation
extension CartCoordinator: Coordinator {
    func start() {
        scene.play(cartShow: show)
    }

    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

// MARK: - CartRouter implementation
extension CartCoordinator: CartRouter {
    func showProductDescription(for storeItem: StoreItem) { }
}

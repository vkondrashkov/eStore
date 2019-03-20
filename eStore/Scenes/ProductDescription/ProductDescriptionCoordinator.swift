//
//  ProductDescriptionCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ProductDescriptionCoordinator {
    private let scene: ProductDescriptionScene
    private let show: ProductDescriptionShow
    
    init(scene: ProductDescriptionScene,
         show: ProductDescriptionShow) {
        self.scene = scene
        self.show = show
    }
}

// MARK: - Coordinator implementation
extension ProductDescriptionCoordinator: Coordinator {
    func start() {
        scene.play(productDescriptionShow: show)
    }
    
    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

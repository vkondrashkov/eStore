//
//  ProductsListCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ProductsListCoordinator {
    private let scene: ProductsListScene
    private let show: ProductsListShow
    
    private let productDescriptionBuilder: ProductDescriptionBuilder
    private var productDescriptionCoordinator: ProductDescriptionCoordinator?
    
    init(scene: ProductsListScene,
         show: ProductsListShow,
         productDescriptionBuilder: ProductDescriptionBuilder) {
        
        self.scene = scene
        self.show = show
        self.productDescriptionBuilder = productDescriptionBuilder
    }
}

// MARK: - Coordinator implementation
extension ProductsListCoordinator: Coordinator {
    func start() {
        scene.play(productsListShow: show)
    }
    
    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

// MARK: - ProductsListRouter implementation
extension ProductsListCoordinator: ProductsListRouter {
    func showProductDescription(for storeItem: StoreItem) {
        productDescriptionCoordinator = productDescriptionBuilder.build(with: storeItem)
        productDescriptionCoordinator?.start()
    }
}

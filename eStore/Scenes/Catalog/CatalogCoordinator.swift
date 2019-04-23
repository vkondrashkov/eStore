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
    
    private let productsListBuilder: ProductsListBuilder
    private var productsListCoordinator: ProductsListCoordinator?
    
    init(scene: CatalogScene,
         show: CatalogShow,
         productsListBuilder: ProductsListBuilder) {
        
        self.scene = scene
        self.show = show
        self.productsListBuilder = productsListBuilder
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

// MARK: - CatalogRouter implementation
extension CatalogCoordinator: CatalogRouter {
    func showProductsList(title: String) {
        guard let productType = ProductType(rawValue: title) else { return }
        productsListCoordinator = productsListBuilder.build(with: productType)
        productsListCoordinator?.start()
    }
}

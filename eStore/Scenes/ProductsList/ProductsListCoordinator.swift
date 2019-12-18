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

    private let smartphoneEditorBuilder: SmartphoneEditorBuilder
    private let laptopEditorBuilder: LaptopEditorBuilder
    private let tvEditorBuilder: TVEditorBuilder
    
    init(scene: ProductsListScene,
         show: ProductsListShow,
         productDescriptionBuilder: ProductDescriptionBuilder,
         smartphoneEditorBuilder: SmartphoneEditorBuilder,
         laptopEditorBuilder: LaptopEditorBuilder,
         tvEditorBuilder: TVEditorBuilder) {
        self.scene = scene
        self.show = show
        self.productDescriptionBuilder = productDescriptionBuilder
        self.smartphoneEditorBuilder = smartphoneEditorBuilder
        self.laptopEditorBuilder = laptopEditorBuilder
        self.tvEditorBuilder = tvEditorBuilder
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

    func showSmartphoneEditor() {
        let provider = smartphoneEditorBuilder.build()
        let coordinator = provider.coordinator
        coordinator?.onTerminate = { [weak coordinator] in
            coordinator?.stop { }
        }
        coordinator?.start()
    }

    func showLaptopEditor() {
        let provider = laptopEditorBuilder.build()
        let coordinator = provider.coordinator
        coordinator?.onTerminate = { [weak coordinator] in
            coordinator?.stop { }
        }
        coordinator?.start()
    }

    func showTVEditor() {
        let provider = tvEditorBuilder.build()
        let coordinator = provider.coordinator
        coordinator?.onTerminate = { [weak coordinator] in
            coordinator?.stop { }
        }
        coordinator?.start()
    }
}

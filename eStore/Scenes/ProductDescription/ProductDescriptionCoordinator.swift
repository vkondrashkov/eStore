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

    private let smartphoneEditorBuilder: SmartphoneEditorBuilder
    private let laptopEditorBuilder: LaptopEditorBuilder
    private let tvEditorBuilder: TVEditorBuilder
    
    init(scene: ProductDescriptionScene,
         show: ProductDescriptionShow,
         smartphoneEditorBuilder: SmartphoneEditorBuilder,
         laptopEditorBuilder: LaptopEditorBuilder,
         tvEditorBuilder: TVEditorBuilder) {
        self.scene = scene
        self.show = show
        self.smartphoneEditorBuilder = smartphoneEditorBuilder
        self.laptopEditorBuilder = laptopEditorBuilder
        self.tvEditorBuilder = tvEditorBuilder
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

// MARK: - ProductDescriptionRouter implementation

extension ProductDescriptionCoordinator: ProductDescriptionRouter {
    func showSmartphoneEditor(smartphone: Smartphone) {
        let provider = smartphoneEditorBuilder.build(with: smartphone)
        let coordinator = provider.coordinator
        coordinator?.onTerminate = { [weak coordinator] in
            coordinator?.stop { }
        }
        coordinator?.start()
    }

    func showLaptopEditor(laptop: Laptop) {
        let provider = laptopEditorBuilder.build(with: laptop)
        let coordinator = provider.coordinator
        coordinator?.onTerminate = { [weak coordinator] in
            coordinator?.stop { }
        }
        coordinator?.start()
    }

    func showTVEditor(tv: TV) {
        let provider = tvEditorBuilder.build(with: tv)
        let coordinator = provider.coordinator
        coordinator?.onTerminate = { [weak coordinator] in
            coordinator?.stop { }
        }
        coordinator?.start()
    }
}

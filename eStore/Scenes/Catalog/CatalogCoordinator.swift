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

    init(scene: CatalogScene,
         show: CatalogShow) {
        self.scene = scene
        self.show = show
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
extension CatalogCoordinator: CatalogRouter { }

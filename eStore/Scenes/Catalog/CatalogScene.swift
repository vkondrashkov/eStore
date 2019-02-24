//
//  CatalogScene.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class CatalogSceneImpl {
    let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
}

// MARK: - ProfileScene implementation
extension CatalogSceneImpl: CatalogScene {
    func play(catalogShow: CatalogShow) {
        rootViewController.viewControllers = [catalogShow.viewController]
    }
}

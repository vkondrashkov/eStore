//
//  ProductDescriptionScene.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductDescriptionSceneImpl {
    let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

// MARK: - ProductDescriptionScene implementation
extension ProductDescriptionSceneImpl: ProductDescriptionScene {
    func play(productDescriptionShow: ProductDescriptionShow) {
        navigation.pushViewController(productDescriptionShow.rootViewController, animated: true)
    }
}

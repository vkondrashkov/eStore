//
//  ProductsListScene.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductsListSceneImpl {
    let navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

// MARK: - ProductsListScene implementation
extension ProductsListSceneImpl: ProductsListScene {
    func play(productsListShow: ProductsListShow) {
        navigation.pushViewController(productsListShow.rootViewController, animated: true)
    }
}

//
//  CartScene.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class CartSceneImpl {
    let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

// MARK: - CartScene implementation
extension CartSceneImpl: CartScene {
    func play(cartShow: CartShow) {
        navigation.viewControllers = [cartShow.rootViewController]
    }
}

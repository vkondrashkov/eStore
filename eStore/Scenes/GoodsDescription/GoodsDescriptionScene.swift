//
//  GoodsDescriptionScene.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class GoodsDescriptionSceneImpl {
    let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

// MARK: - GoodsDescriptionScene implementation
extension GoodsDescriptionSceneImpl: GoodsDescriptionScene {
    func play(goodsDescriptionShow: GoodsDescriptionShow) {
        navigation.pushViewController(goodsDescriptionShow.rootViewController, animated: true)
    }
}

//
//  GoodsListScene.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class GoodsListSceneImpl {
    let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

// MARK: - GoodsListScene implementation
extension GoodsListSceneImpl: GoodsListScene {
    func play(goodsListShow: GoodsListShow) {
        navigation.pushViewController(goodsListShow.rootViewController, animated: true)
    }
}

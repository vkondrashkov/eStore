//
//  GoodsDescriptionContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol GoodsDescriptionDependency: AnyObject {
    var navigation: UINavigationController { get }
}

protocol GoodsDescriptionBuilder: AnyObject {
    func build(with dataSource: GoodsDescriptionTableViewDataSource) -> GoodsDescriptionCoordinator
}

protocol GoodsDescriptionScene: AnyObject {
    func play(goodsDescriptionShow: GoodsDescriptionShow)
}

protocol GoodsDescriptionShow: AnyObject {
    var rootViewController: UIViewController { get }
}

protocol GoodsDescriptionView: AnyObject {

}

protocol GoodsDescriptionPresenter: AnyObject {
    func handleLoadView()
}

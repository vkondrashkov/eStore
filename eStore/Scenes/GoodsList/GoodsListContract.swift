//
//  GoodsListContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol GoodsListDependency: AnyObject {
    var navigation: UINavigationController { get }
}

protocol GoodsListBuilder: AnyObject {
    func build(title: String) -> GoodsListCoordinator
}

protocol GoodsListScene: AnyObject {
    func play(goodsListShow: GoodsListShow)
}

protocol GoodsListShow: AnyObject {
    var rootViewController: UIViewController { get }
}

protocol GoodsListView: AnyObject {
    // TODO: Think over display(_:) methods
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol GoodsListPresenter: AnyObject {
    func handleLoadView()
}

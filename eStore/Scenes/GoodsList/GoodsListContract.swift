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
    func build(with productType: ProductType) -> GoodsListCoordinator
}

protocol GoodsListScene: AnyObject {
    func play(goodsListShow: GoodsListShow)
}

protocol GoodsListShow: AnyObject {
    var rootViewController: UIViewController { get }
}

protocol GoodsListRouter: AnyObject {
    func showGoodsDescription(for storeItem: StoreItem)
}

protocol GoodsListView: AnyObject {
    func showActivityIndicator()
    func hideActivityIndicator()
    func display(storeItemList: [StoreItem])
}

protocol GoodsListPresenter: AnyObject {
    func handleLoadView()

    // Should I only handle indexPath and hold
    // dataSource in Presenter?
    func handleProductPress(storeItem: StoreItem)
}

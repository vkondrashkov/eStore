//
//  ProductsListContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol ProductsListDependency: AnyObject {
    var navigation: UINavigationController { get }
    var themeManager: ThemeManager { get }
}

protocol ProductsListBuilder: AnyObject {
    func build(with productType: ProductType) -> ProductsListCoordinator
}

protocol ProductsListScene: AnyObject {
    func play(productsListShow: ProductsListShow)
}

protocol ProductsListShow: AnyObject {
    var rootViewController: UIViewController { get }
}

protocol ProductsListRouter: AnyObject {
    func showProductDescription(for storeItem: StoreItem)
}

protocol ProductsListView: AnyObject, ThemeUpdatable {
    func showActivityIndicator()
    func hideActivityIndicator()
    func display(storeItemList: [StoreItem])
}

protocol ProductsListPresenter: AnyObject {
    func handleLoadView()
    func handleProductPress(storeItem: StoreItem)
}

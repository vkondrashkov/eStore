//
//  CartContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol CartDependency: AnyObject {
    var cartNavigation: UINavigationController { get }
    var themeManager: ThemeManager { get }
}

protocol CartBuilder: AnyObject {
    func build() -> CartCoordinator
}

protocol CartScene: AnyObject {
    func play(cartShow: CartShow)
}

protocol CartShow: AnyObject {
    var rootViewController: UIViewController { get }
}

protocol CartRouter: AnyObject {
    func showProductDescription(for storeItem: StoreItem)
}

protocol CartView: AnyObject, ThemeUpdatable {
    func showActivityIndicator()
    func hideActivityIndicator()
    func display(storeItemList: [StoreItem])
}

protocol CartPresenter: AnyObject {
    func handleLoadView()
    func handleProductPress(storeItem: StoreItem)
}

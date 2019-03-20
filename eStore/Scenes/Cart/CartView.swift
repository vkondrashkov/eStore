//
//  CartView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class CartViewImpl: UIViewController {
    var presenter: CartPresenter!
}

// MARK: - CartView implementation
extension CartViewImpl: CartView {
    func showActivityIndicator() { }

    func hideActivityIndicator() { }

    func display(storeItemList: [StoreItem]) { }
}

// MARK: - CartShow implementation
extension CartViewImpl: CartShow {
    var rootViewController: UIViewController {
        return self
    }
}

// MARK: - Constraints
private extension CartViewImpl {

}

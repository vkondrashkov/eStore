//
//  CartPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

// TODO: Add networking service to initializier
final class CartPresenterImpl {
    private unowned let view: CartView
    private unowned let router: CartRouter

    init(view: CartView,
         router: CartRouter) {

        self.view = view
        self.router = router
    }
}

// MARK: - CartPresenter implementation
extension CartPresenterImpl: CartPresenter {
    func handleLoadView() {
        view.showActivityIndicator()
        let service = ProductsServiceImpl()
        service.getSmartphone(completion: { [weak self] result in
            guard let storeItemList = result else {
                // TODO: Error handling
                return
            }
            self?.view.display(storeItemList: storeItemList)
            self?.view.hideActivityIndicator()
        })
    }

    func handleProductPress(storeItem: StoreItem) { }
}

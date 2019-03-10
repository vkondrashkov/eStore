//
//  GoodsListPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

// TODO: Add networking service to initializier
final class GoodsListPresenterImpl {
    private unowned let view: GoodsListView
    private unowned let router: GoodsListRouter

    private let productType: ProductType

    init(view: GoodsListView,
         router: GoodsListRouter,
         productType: ProductType) {

        self.view = view
        self.router = router
        self.productType = productType
    }
}

// MARK: - GoodsListPresenter implementation
extension GoodsListPresenterImpl: GoodsListPresenter {
    func handleLoadView() {
        // Temp
        view.showActivityIndicator()
        let tempSpecifications: [Specification] = [
            Specification(name: "Foo", value: "Bar"),
            Specification(name: "Foo", value: "Bar"),
            Specification(name: "Foo", value: "Bar"),
            Specification(name: "Foo", value: "Bar"),
            Specification(name: "Foo", value: "Bar"),
            Specification(name: "Foo", value: "Bar")
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            let storeItems: [StoreItem] = [
                StoreItem(id: "123", name: "Foo", brand: "Foo", type: .Smartphone, specifications: tempSpecifications, price: 1),
                StoreItem(id: "456", name: "Bar", brand: "Bar", type: .Smartphone, specifications: tempSpecifications, price: 2),
                StoreItem(id: "789", name: "FooBar", brand: "FooBar", type: .Smartphone, specifications: tempSpecifications, price: 1),
            ]
            self?.view.display(storeItemList: storeItems)
            self?.view.hideActivityIndicator()
        })
    }

    func handleProductPress(storeItem: StoreItem) {
        router.showGoodsDescription(for: storeItem)
    }
}

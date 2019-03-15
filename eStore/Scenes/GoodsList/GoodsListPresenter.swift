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
        view.showActivityIndicator()
        // TODO: Dependency injection
        let service = GoodsServiceImpl()

        switch productType {
        case .Smartphone:
            service.getSmartphone(completion: { [weak self] result in
                guard let storeItemList = result else {
                    // TODO: Error handling
                    return
                }
                self?.view.display(storeItemList: storeItemList)
                self?.view.hideActivityIndicator()
            })
        case .Laptop:
            service.getLaptops(completion: { [weak self] result in
                guard let storeItemList = result else {
                    // TODO: Error handling
                    return
                }
                self?.view.display(storeItemList: storeItemList)
                self?.view.hideActivityIndicator()
            })
        case .TV:
            service.getTV(completion: { [weak self] result in
                guard let storeItemList = result else {
                    // TODO: Error handling
                    return
                }
                self?.view.display(storeItemList: storeItemList)
                self?.view.hideActivityIndicator()
            })
        }
    }

    func handleProductPress(storeItem: StoreItem) {
        router.showGoodsDescription(for: storeItem)
    }
}

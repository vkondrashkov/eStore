//
//  ProductsListPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

// TODO: Add networking service to initializier
final class ProductsListPresenterImpl {
    private unowned let view: ProductsListView
    private unowned let router: ProductsListRouter
    
    private let productType: ProductType
    
    init(view: ProductsListView,
         router: ProductsListRouter,
         productType: ProductType) {
        
        self.view = view
        self.router = router
        self.productType = productType
    }
}

// MARK: - ProductsListPresenter implementation
extension ProductsListPresenterImpl: ProductsListPresenter {
    func handleLoadView() {
        view.showActivityIndicator()
        // TODO: Dependency injection
        let service = ProductsServiceImpl()
        
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
        router.showProductDescription(for: storeItem)
    }
}
//
//  ProductsListPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

final class ProductsListPresenterImpl {
    private unowned let view: ProductsListView
    private unowned let router: ProductsListRouter
    private let productsService: ProductsService
    private unowned let themeManager: ThemeManager
    
    private let productType: ProductType
    
    init(view: ProductsListView,
         router: ProductsListRouter,
         productsService: ProductsService,
         productType: ProductType,
         themeManager: ThemeManager) {
        
        self.view = view
        self.router = router
        self.productsService = productsService
        self.productType = productType
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }
}

// MARK: - ProductsListPresenter implementation
extension ProductsListPresenterImpl: ProductsListPresenter {
    func handleLoadView() {
        view.showActivityIndicator()
        
        switch productType {
        case .Smartphone:
            productsService.getSmartphone(completion: { [weak self] result in
                guard let storeItemList = result else {
                    // TODO: Error handling
                    return
                }
                self?.view.display(storeItemList: storeItemList)
                self?.view.hideActivityIndicator()
            })
        case .Laptop:
            productsService.getLaptops(completion: { [weak self] result in
                guard let storeItemList = result else {
                    // TODO: Error handling
                    return
                }
                self?.view.display(storeItemList: storeItemList)
                self?.view.hideActivityIndicator()
            })
        case .TV:
            productsService.getTV(completion: { [weak self] result in
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

// MARK: - ThemeObserver implementation
extension ProductsListPresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) {
        view.update(theme: theme, animated: false)
    }
}

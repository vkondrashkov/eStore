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
    private let interactor: ProductsListInteractor
    private let productsService: ProductsService
    private unowned let themeManager: ThemeManager
    
    private let productType: ProductType
    
    init(view: ProductsListView,
         router: ProductsListRouter,
         interactor: ProductsListInteractor,
         productsService: ProductsService,
         productType: ProductType,
         themeManager: ThemeManager) {
        
        self.view = view
        self.router = router
        self.interactor = interactor
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
            interactor.fetchSmartphones(completion: { [weak self] result in
                self?.view.hideActivityIndicator()
                guard let smartphones = result.value else {
                    return
                }
                let storeItems = smartphones.map { $0.toStoreItem() }
                self?.view.display(storeItemList: storeItems)
            })
        case .Laptop:
            interactor.fetchLaptops(completion: { [weak self] result in
                self?.view.hideActivityIndicator()
                guard let laptops = result.value else {
                    return
                }
                let storeItems = laptops.map { $0.toStoreItem() }
                self?.view.display(storeItemList: storeItems)
            })
        case .TV:
            interactor.fetchTVs(completion: { [weak self] result in
                self?.view.hideActivityIndicator()
                guard let tvs = result.value else {
                    return
                }
                let storeItems = tvs.map { $0.toStoreItem() }
                self?.view.display(storeItemList: storeItems)
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

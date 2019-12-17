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
    private unowned let themeManager: ThemeManager
    
    private let productType: ProductType
    
    init(view: ProductsListView,
         router: ProductsListRouter,
         interactor: ProductsListInteractor,
         productType: ProductType,
         themeManager: ThemeManager) {
        
        self.view = view
        self.router = router
        self.interactor = interactor
        self.productType = productType
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }

    private func reloadProductsList() {
        switch productType {
        case .smartphone:
            interactor.fetchSmartphones(completion: { [weak self] result in
                self?.view.hideActivityIndicator()
                guard let smartphones = result.value else {
                    return
                }
                let storeItems = smartphones.map { $0.toStoreItem() }
                self?.view.display(storeItemList: storeItems)
            })
        case .laptop:
            interactor.fetchLaptops(completion: { [weak self] result in
                self?.view.hideActivityIndicator()
                guard let laptops = result.value else {
                    return
                }
                let storeItems = laptops.map { $0.toStoreItem() }
                self?.view.display(storeItemList: storeItems)
            })
        case .tv:
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

    private func deleteStoreItem(storeItem: StoreItem) {
        switch storeItem.type {
        case .smartphone:
            interactor.deleteSmartphone(id: storeItem.id, completion: { [weak self] _ in
                self?.reloadProductsList()
            })
        case .laptop:
            interactor.deleteSmartphone(id: storeItem.id, completion: { [weak self] _ in
                self?.reloadProductsList()
            })
        case .tv:
            interactor.deleteTV(id: storeItem.id, completion: { [weak self] _ in
                self?.reloadProductsList()
            })
        }
    }
}

// MARK: - ProductsListPresenter implementation
extension ProductsListPresenterImpl: ProductsListPresenter {
    func configureEditActions(for indexPath: IndexPath) -> [(title: String, isDestructive: Bool, action: ((StoreItem) -> Void)?)] {
        guard let user = interactor.currentUser else {
            return []
        }
        var actions: [(title: String, isDestructive: Bool, action: ((StoreItem) -> Void)?)] = []
        if user.role.rawValue >= User.Role.moderator.rawValue {
            actions.append((title: "Delete", isDestructive: true, action: { [weak self] storeItem in
                self?.handleDeleteProduct(storeItem: storeItem)
            }))
        }
        actions.append((title: "Add to cart", isDestructive: false, action: { [weak self] storeItem in
            self?.handleCartAddition(storeItem: storeItem)
        }))
        return actions
    }

    func handleLoadView() {
        view.showActivityIndicator()
        
        reloadProductsList()

        if let user = interactor.currentUser, user.role.rawValue >= User.Role.moderator.rawValue {
            view.display(rightBarButtonTitle: "Add")
        }
    }
    
    func handleProductPress(storeItem: StoreItem) {
        router.showProductDescription(for: storeItem)
    }

    func handleDeleteProduct(storeItem: StoreItem) {
        view.display(alert: Alert(
            title: "Confirm deleting",
            message: "Are you sure you want to delete this item? This action can't be undo.",
            alertType: .doubleAction,
            primaryCaption: "OK",
            primaryAction: { [weak self] in
                self?.deleteStoreItem(storeItem: storeItem)
            },
            secondaryCaption: "Cancel",
            secondaryAction: nil
        ))
    }

    func handleCartAddition(storeItem: StoreItem) {
        interactor.addToCart(
            productId: storeItem.id,
            productTypeId: storeItem.type.rawValue,
            completion: { [weak self] error in
                guard error == nil else {
                    self?.view.display(alert: Alert(
                        title: "Oops..",
                        message: "Something went wrong. Try again later.",
                        alertType: .singleAction,
                        primaryCaption: "OK",
                        primaryAction: nil,
                        secondaryCaption: nil,
                        secondaryAction: nil
                    ))
                    return
                }
            }
        )
    }

    func handleAddProductPress() {
        switch productType {
        case .smartphone:
            router.showSmartphoneEditor()
        case .laptop:
            router.showLaptopEditor()
        case .tv:
            router.showTVEditor()
        }
    }
}

// MARK: - ThemeObserver implementation
extension ProductsListPresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) {
        view.update(theme: theme, animated: false)
    }
}

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
    private let interactor: CartInteractor
    private unowned let themeManager: ThemeManager

    init(view: CartView,
         router: CartRouter,
         interactor: CartInteractor,
         themeManager: ThemeManager) {

        self.view = view
        self.router = router
        self.interactor = interactor
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }

    private func reloadCart() {
        interactor.fetch(completion: { [weak self] cartItems in
            DispatchQueue.main.async {
                self?.view.hideActivityIndicator()
                switch cartItems {
                case .success(let items):
                    let storeItems = items.map { $0.toStoreItem() }
                    self?.view.display(storeItemList: storeItems)
                case .failure:
                    break
                    // TODO: display error on screen
                }
            }
        })
    }
}

// MARK: - CartPresenter implementation
extension CartPresenterImpl: CartPresenter {
    func handleLoadView() {
        view.showActivityIndicator()
//        reloadCart()
    }

    func shouldViewAppear() {
        reloadCart()
    }

    func handleRefresh() {
        reloadCart()
    }

    func handleProductPress(storeItem: StoreItem) {

    }

    func handleProductDelete(storeItem: StoreItem) {
        interactor.delete(storeItemId: storeItem.id, completion: { [weak self] _ in
            self?.reloadCart()
        })
    }
}

// MARK: - ThemeObserver implementation
extension CartPresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) {
        view.update(theme: theme, animated: false)
    }
}

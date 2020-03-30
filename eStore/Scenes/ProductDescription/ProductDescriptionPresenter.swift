//
//  ProductDescriptionPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

final class ProductDescriptionPresenterImpl {
    private unowned let view: ProductDescriptionView
    private unowned let router: ProductDescriptionRouter
    private let interactor: ProductDescriptionInteractor
    private unowned let themeManager: ThemeManager
    
    init(view: ProductDescriptionView,
         router: ProductDescriptionRouter,
         interactor: ProductDescriptionInteractor,
         themeManager: ThemeManager) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }
}

// MARK: - ProductDescriptionPresenter implementation
extension ProductDescriptionPresenterImpl: ProductDescriptionPresenter {
    func handleLoadView() {
        if let user = interactor.currentUser, user.role.rawValue >= User.Role.contentMaker.rawValue {
            view.display(rightBarButtonTitle: "Edit")
        }
    }

    func handleRefresh(storeItem: StoreItem) {
        requestAccordingType(storeItem: storeItem, completion: { [weak self] updatedStoreItem in
            self?.view.hideActivityIndicator()
            self?.view.update(storeItem: updatedStoreItem)
        })
    }

    func handleEditPress(storeItem: StoreItem) {
        switch storeItem.type {
        case .smartphone:
            interactor.fetchSmartphone(id: String(storeItem.id), completion: { [weak self] result in
                guard let smartphone = result.value else {
                    return
                }
                self?.router.showSmartphoneEditor(smartphone: smartphone)
            })
        case .laptop:
            interactor.fetchLaptop(id: String(storeItem.id), completion: { [weak self] result in
                guard let laptop = result.value else {
                    return
                }
                self?.router.showLaptopEditor(laptop: laptop)
            })
        case .tv:
            interactor.fetchTV(id: String(storeItem.id), completion: { [weak self] result in
                guard let tv = result.value else {
                    return
                }
                self?.router.showTVEditor(tv: tv)
            })
        }
    }

    func cartAddButtonDidPress(id: Int, productTypeId: Int) {
        interactor.addToCart(productId: id, productTypeId: productTypeId, completion: { [weak self] error in
            if error != nil {
                let alert = Alert(
                    title: "Oops...",
                    message: "Something went wrong. Try again later.",
                    alertType: .singleAction,
                    primaryCaption: "OK",
                    primaryAction: nil,
                    secondaryCaption: nil,
                    secondaryAction: nil
                )
                self?.view.display(alert: alert)
            }
        })
    }
}

// MARK: - ThemeObserver implementation
extension ProductDescriptionPresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) {
        view.update(theme: theme, animated: false)
    }
}

private extension ProductDescriptionPresenterImpl {
    func requestAccordingType(storeItem: StoreItem, completion: ((StoreItem) -> Void)?) {
        switch storeItem.type {
        case .smartphone:
            interactor.fetchSmartphone(id: String(storeItem.id), completion: { [weak self] result in
                guard let smartphone = result.value else {
                    return
                }
                completion?(smartphone.toStoreItem())
            })
        case .laptop:
            interactor.fetchLaptop(id: String(storeItem.id), completion: { [weak self] result in
                guard let laptop = result.value else {
                    return
                }
                completion?(laptop.toStoreItem())
            })
        case .tv:
            interactor.fetchTV(id: String(storeItem.id), completion: { [weak self] result in
                guard let tv = result.value else {
                    return
                }
                completion?(tv.toStoreItem())
            })
        }
    }
}

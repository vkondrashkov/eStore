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
    private let interactor: ProductDescriptionInteractor
    private unowned let themeManager: ThemeManager
    
    init(view: ProductDescriptionView,
         interactor: ProductDescriptionInteractor,
         themeManager: ThemeManager) {
        self.view = view
        self.interactor = interactor
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }
}

// MARK: - ProductDescriptionPresenter implementation
extension ProductDescriptionPresenterImpl: ProductDescriptionPresenter {
    func handleLoadView() { }

    func cartAddButtonDidPress(id: Int, productTypeId: Int) {
        interactor.addToCart(id: id, productTypeId: productTypeId, completion: { [weak self] error in
            if let error = error {
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


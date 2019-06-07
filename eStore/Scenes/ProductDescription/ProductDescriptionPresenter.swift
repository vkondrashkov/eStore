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
    private unowned let themeManager: ThemeManager
    
    init(view: ProductDescriptionView,
         themeManager: ThemeManager) {
        self.view = view
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }
}

// MARK: - ProductDescriptionPresenter implementation
extension ProductDescriptionPresenterImpl: ProductDescriptionPresenter {
    func handleLoadView() { }

    func cartAddButtonDidPress() {
        let alert = Alert(
            title: "Oops...",
            message: "Unfortunately this feature is unavailable, try again later.",
            alertType: .singleAction,
            primaryCaption: "OK",
            primaryAction: nil,
            secondaryCaption: nil,
            secondaryAction: nil
        )
        view.display(alert: alert)
    }
}

// MARK: - ThemeObserver implementation
extension ProductDescriptionPresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) {
        view.update(theme: theme, animated: false)
    }
}


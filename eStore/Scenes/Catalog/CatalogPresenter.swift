//
//  CatalogPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

final class CatalogPresenterImpl {
    private unowned let view: CatalogView
    private unowned let router: CatalogRouter
    private unowned let themeManager: ThemeManager
    
    init(view: CatalogView,
         router: CatalogRouter,
         themeManager: ThemeManager) {
        
        self.view = view
        self.router = router
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }
}

// MARK: - CatalogPresenter implementation
extension CatalogPresenterImpl: CatalogPresenter {
    func handleLoadView() { }
    
    // TEMP
    func handleCategoryPress(title: String) {
        router.showProductsList(title: title)
    }
}

// MARK: - ThemeObserver implementation
extension CatalogPresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) {
        view.update(theme: theme, animated: false)
    }
}

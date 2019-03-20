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
    
    init(view: CatalogView,
         router: CatalogRouter) {
        
        self.view = view
        self.router = router
    }
}

// MARK: - CatalogPresenter implementation
extension CatalogPresenterImpl: CatalogPresenter {
    func handleLoadView() {
        
    }
    
    // TEMP
    func handleCategoryPress(title: String) {
        router.showProductsList(title: title)
    }
}

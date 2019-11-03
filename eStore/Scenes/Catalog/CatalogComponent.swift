//
//  CatalogComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class CatalogComponent {
    let navigation: UINavigationController
    let productsService: ProductsService
    let themeManager: ThemeManager
    let alertFactory: AlertFactory
    
    init(navigation: UINavigationController,
         productsService: ProductsService,
         themeManager: ThemeManager,
         alertFactory: AlertFactory) {

        self.navigation = navigation
        self.productsService = productsService
        self.themeManager = themeManager
        self.alertFactory = alertFactory
    }
}

// MARK: - ProductsListDependency implementation
extension CatalogComponent: ProductsListDependency { }

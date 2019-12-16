//
//  CatalogComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class CatalogComponent: ProductsListDependency {
    let navigation: UINavigationController
    let productsUseCase: ProductsUseCase
    let productsService: ProductsService
    let themeManager: ThemeManager
    let alertFactory: AlertFactory
    
    init(navigation: UINavigationController,
         productsUseCase: ProductsUseCase,
         productsService: ProductsService,
         themeManager: ThemeManager,
         alertFactory: AlertFactory) {
        self.navigation = navigation
        self.productsUseCase = productsUseCase
        self.productsService = productsService
        self.themeManager = themeManager
        self.alertFactory = alertFactory
    }
}

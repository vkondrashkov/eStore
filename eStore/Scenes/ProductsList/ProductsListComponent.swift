//
//  ProductsListComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductsListComponent: ProductDescriptionDependency {
    let navigation: UINavigationController
    let cartRepository: CartRepository
    let themeManager: ThemeManager
    let alertFactory: AlertFactory
    
    init(navigation: UINavigationController,
         cartRepository: CartRepository,
         themeManager: ThemeManager,
         alertFactory: AlertFactory) {

        self.navigation = navigation
        self.cartRepository = cartRepository
        self.themeManager = themeManager
        self.alertFactory = alertFactory
    }
}

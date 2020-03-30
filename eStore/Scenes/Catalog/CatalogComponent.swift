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
    let userRepository: UserRepository
    let cartRepository: CartRepository
    let productsUseCase: ProductsUseCase
    let themeManager: ThemeManager
    let alertFactory: AlertFactory
    
    init(navigation: UINavigationController,
         userRepository: UserRepository,
         cartRepository: CartRepository,
         productsUseCase: ProductsUseCase,
         themeManager: ThemeManager,
         alertFactory: AlertFactory) {
        self.navigation = navigation
        self.userRepository = userRepository
        self.cartRepository = cartRepository
        self.productsUseCase = productsUseCase
        self.themeManager = themeManager
        self.alertFactory = alertFactory
    }
}

//
//  ProductsListComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductsListComponent: ProductDescriptionDependency, SmartphoneEditorDependency {
    let navigation: UINavigationController
    let smartphoneEditorScene: SmartphoneEditorScene
    let userRepository: UserRepository
    let cartRepository: CartRepository
    let productsUseCase: ProductsUseCase
    let themeManager: ThemeManager
    let alertFactory: AlertFactory
    
    init(navigation: UINavigationController,
         smartphoneEditorScene: SmartphoneEditorScene,
         userRepository: UserRepository,
         cartRepository: CartRepository,
         productsUseCase: ProductsUseCase,
         themeManager: ThemeManager,
         alertFactory: AlertFactory) {
        self.navigation = navigation
        self.smartphoneEditorScene = smartphoneEditorScene
        self.userRepository = userRepository
        self.cartRepository = cartRepository
        self.productsUseCase = productsUseCase
        self.themeManager = themeManager
        self.alertFactory = alertFactory
    }
}

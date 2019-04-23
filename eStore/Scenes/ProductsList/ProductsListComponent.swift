//
//  ProductsListComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductsListComponent {
    let navigation: UINavigationController
    let themeManager: ThemeManager
    let alertFactory: AlertFactory
    
    init(navigation: UINavigationController,
         themeManager: ThemeManager,
         alertFactory: AlertFactory) {

        self.navigation = navigation
        self.themeManager = themeManager
        self.alertFactory = alertFactory
    }
}

// MARK: - ProductDescriptionDependency implementation
extension ProductsListComponent: ProductDescriptionDependency { }

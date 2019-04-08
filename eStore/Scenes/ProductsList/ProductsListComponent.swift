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
    
    init(navigation: UINavigationController,
         themeManager: ThemeManager) {

        self.navigation = navigation
        self.themeManager = themeManager
    }
}

// MARK: - ProductDescriptionDependency implementation
extension ProductsListComponent: ProductDescriptionDependency { }

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
    let themeManager: ThemeManager
    
    init(navigation: UINavigationController,
         themeManager: ThemeManager) {

        self.navigation = navigation
        self.themeManager = themeManager
    }
}

// MARK: - ProductsListDependency implementation
extension CatalogComponent: ProductsListDependency { }

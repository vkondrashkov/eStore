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
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

// MARK: - ProductDescriptionDependency implementation
extension ProductsListComponent: ProductDescriptionDependency { }

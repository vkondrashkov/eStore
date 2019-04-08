//
//  ProductDescriptionComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProductDescriptionComponent {
    let navigation: UINavigationController
    let themeManager: ThemeManager
    
    init(navigation: UINavigationController,
         themeManager: ThemeManager) {

        self.navigation = navigation
        self.themeManager = themeManager
    }
}


//
//  CartComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class CartComponent {
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

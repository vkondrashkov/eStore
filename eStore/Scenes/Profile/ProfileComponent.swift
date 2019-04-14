//
//  ProfileComponent.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileComponent {
    let rootViewController: UIViewController
    let themeManager: ThemeManager

    init(rootViewController: UIViewController,
         themeManager: ThemeManager) {

        self.rootViewController = rootViewController
        self.themeManager = themeManager
    }
}

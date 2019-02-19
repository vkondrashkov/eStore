//
//  AppComponent.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class AppComponent {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - RootDependency implementation
extension AppComponent: RootDependency {
    var parent: UIWindow {
        return window
    }
}

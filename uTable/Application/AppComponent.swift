//
//  AppComponent.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class AppComponent: Component<EmptyDependency> {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init(dependency: EmptyComponent())
    }
}

extension AppComponent: RootDependency { }

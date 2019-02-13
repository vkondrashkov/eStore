//
//  RootScene.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootSceneImpl {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - RootScene implementation
extension RootSceneImpl: RootScene {
    func play(rootShow: RootShow) {
        window.rootViewController = rootShow.viewController
        window.makeKeyAndVisible()
    }
}

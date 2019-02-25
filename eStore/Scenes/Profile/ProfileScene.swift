//
//  ProfileScene.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileSceneImpl {
    let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
}

// MARK: - ProfileScene implementation
extension ProfileSceneImpl: ProfileScene {
    func play(profileShow: ProfileShow) {
        rootViewController.viewControllers = [profileShow.viewController]
    }
}

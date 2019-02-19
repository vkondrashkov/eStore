//
//  SignInScene.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/15/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignInSceneImpl {
    let navViewController: UINavigationController

    init(navViewController: UINavigationController) {
        self.navViewController = navViewController
    }
}

// MARK: - SignInScene implementation
extension SignInSceneImpl: SignInScene {
    func play(signInShow: SignInShow) {
        navViewController.viewControllers = [signInShow.rootViewController]
    }
}

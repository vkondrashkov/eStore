//
//  SignUpScene.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignUpSceneImpl {
    let navViewController: UINavigationController

    init(navViewController: UINavigationController) {
        self.navViewController = navViewController
    }
}

// MARK: - SignUpScene implementation
extension SignUpSceneImpl: SignUpScene {
    func play(signUpShow: SignUpShow) {
        navViewController.viewControllers = [signUpShow.rootViewController]
    }
}

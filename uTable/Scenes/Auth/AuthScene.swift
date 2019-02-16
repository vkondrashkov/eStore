//
//  AuthScene.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class AuthSceneImpl {
    private let rootViewController: UIViewController

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
}

// MARK: - AuthScene implementation
extension AuthSceneImpl: AuthScene {
    func play(authShow: AuthShow) {
        rootViewController.present(authShow.navViewController, animated: true, completion: nil)
    }

    func finish(completion: (() -> Void)?) {
        rootViewController.dismiss(animated: true, completion: completion)
    }
}

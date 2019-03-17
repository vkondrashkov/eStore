//
//  ProfileCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileCoordinator {
    private let scene: ProfileScene
    private let show: ProfileShow
    private weak var listener: ProfileListener?

    init(scene: ProfileScene,
         show: ProfileShow,
         listener: ProfileListener) {

        self.scene = scene
        self.show = show
        self.listener = listener
    }
}

// MARK: - Coordinator implementation
extension ProfileCoordinator: Coordinator {
    func start() {
        scene.play(profileShow: show)
    }

    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

// MARK: - ProfileRouter implementation
extension ProfileCoordinator: ProfileRouter {
    func logout() {
        listener?.logout()
    }

    func showSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    func showCart() {

    }

    func showContact() {
        guard let url = URL(string: "https://github.com/vkondrashkov/eStore") else { return }
        UIApplication.shared.open(url)
    }
}

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

    private let themeSettingsBuilder: ThemeSettingsBuilder
    private var themeSettingsCoordinator: ThemeSettingsCoordinator?

    init(scene: ProfileScene,
         show: ProfileShow,
         themeSettingsBuilder: ThemeSettingsBuilder,
         listener: ProfileListener) {

        self.scene = scene
        self.show = show
        self.themeSettingsBuilder = themeSettingsBuilder
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
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }

    func showCart() {

    }

    func showContact() {
        guard let url = URL(string: "https://github.com/vkondrashkov/eStore") else { return }
        UIApplication.shared.open(url)
    }

    func showThemeSettings() {
        themeSettingsCoordinator = themeSettingsBuilder.build()
        themeSettingsCoordinator?.start()
    }
}

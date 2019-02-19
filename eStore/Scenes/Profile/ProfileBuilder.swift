//
//  ProfileBuilder.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileBuilderImpl {
    private let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

// MARK: - ProfileBuilder implementation
extension ProfileBuilderImpl: ProfileBuilder {
    func build() -> ProfileCoordinator {
        let view = ProfileViewImpl()
        let component = ProfileComponent(rootViewController: view)
        let scene = ProfileSceneImpl(rootViewController: navigation)
        let coordinator = ProfileCoordinator(scene: scene,
                                             show: view)
        let presenter = ProfilePresenterImpl(view: view,
                                             router: coordinator)
        view.presenter = presenter
        return coordinator
    }
}

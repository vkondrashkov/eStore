//
//  ProfileBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileBuilderImpl {
    private let dependency: ProfileDependency

    init(dependency: ProfileDependency) {
        self.dependency = dependency
    }
}

// MARK: - ProfileBuilder implementation
extension ProfileBuilderImpl: ProfileBuilder {
    func build(with listener: ProfileListener) -> ProfileCoordinator {
        let view = ProfileViewImpl()
        let component = ProfileComponent(
            rootViewController: view,
            themeManager: dependency.themeManager
        )
        let scene = ProfileSceneImpl(rootViewController: dependency.profileNavigation)
        let coordinator = ProfileCoordinator(scene: scene,
                                             show: view,
                                             listener: listener)
        let presenter = ProfilePresenterImpl(
            view: view,
            router: coordinator,
            themeManager: dependency.themeManager
        )
        view.presenter = presenter
        return coordinator
    }
}

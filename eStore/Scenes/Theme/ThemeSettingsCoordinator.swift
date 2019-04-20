//
//  ThemeCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/7/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ThemeSettingsCoordinator {
    private let scene: ThemeSettingsScene
    private let show: ThemeSettingsShow

    init(scene: ThemeSettingsScene,
         show: ThemeSettingsShow) {
        self.scene = scene
        self.show = show
    }
}

// MARK: - Coordinator implementation
extension ThemeSettingsCoordinator: Coordinator {
    func start() {
        scene.play(themeSettingsShow: show)
    }

    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

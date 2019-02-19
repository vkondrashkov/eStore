//
//  ProfileCoordinator.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ProfileCoordinator {
    private let scene: ProfileScene
    private let show: ProfileShow

    init(scene: ProfileScene,
         show: ProfileShow) {
        self.scene = scene
        self.show = show
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
extension ProfileCoordinator: ProfileRouter { }

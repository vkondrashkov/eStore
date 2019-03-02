//
//  ProfileCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

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
}

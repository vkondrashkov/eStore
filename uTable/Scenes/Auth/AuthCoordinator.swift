//
//  AuthCoordinator.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class AuthCoordinator {
    private let scene: AuthScene
    private let show: AuthShow

    init(scene: AuthScene,
         show: AuthShow) {
        self.scene = scene
        self.show = show
    }
}

// MARK: - Coordinator implementation
extension AuthCoordinator: Coordinator {
    func start() {
        scene.play(authShow: show)
    }

    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

// MARK: - AuthRouter implementation
extension AuthCoordinator: AuthRouter {
    func showSignUp() {
        // TODO:
    }

    func showSignIn() {
        // TODO:
    }
}

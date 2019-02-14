//
//  SignInCoordinator.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/15/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class SignInCoordinator {
    private let scene: SignInScene
    private let show: SignInShow

    init(scene: SignInScene,
         show: SignInShow) {
        self.scene = scene
        self.show = show
    }
}

// MARK: - Coordinator implementation
extension SignInCoordinator: Coordinator {
    func start() {
        scene.play(signInShow: show)
    }

    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

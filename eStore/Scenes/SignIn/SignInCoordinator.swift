//
//  SignInCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/15/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class SignInCoordinator {
    private let scene: SignInScene
    private let show: SignInShow
    private weak var listener: SignInListener?

    init(scene: SignInScene,
         show: SignInShow,
         listener: SignInListener) {

        self.scene = scene
        self.show = show
        self.listener = listener
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

// MARK: - SignInRouter implementation
extension SignInCoordinator: SignInRouter {
    func completeSignIn() {
        listener?.signIn()
    }

    func routeSignUp() {
        listener?.showSignUp()
    }
}

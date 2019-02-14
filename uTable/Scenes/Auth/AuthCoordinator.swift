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

    private let signUpBuilder: SignUpBuilder
    private var signUpCoordinator: SignUpCoordinator?

    init(scene: AuthScene,
         show: AuthShow,
         signUpBuilder: SignUpBuilder) {
        self.scene = scene
        self.show = show
        self.signUpBuilder = signUpBuilder
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
    func routeSignUp() {
        signUpCoordinator = signUpBuilder.build(with: self)
        signUpCoordinator?.start()
    }

    func routeSignIn() {
        // TODO:
    }
}

extension AuthCoordinator: SignUpListener {
    func showSignIn() {
        signUpCoordinator?.stop(completion: { [weak self] in
            self?.signUpCoordinator = nil
        })
        routeSignIn()
    }
}

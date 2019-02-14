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

    private let signInBuilder: SignInBuilder
    private var signInCoordinator: SignInCoordinator?

    init(scene: AuthScene,
         show: AuthShow,
         signUpBuilder: SignUpBuilder,
         signInBuilder: SignInBuilder) {
        self.scene = scene
        self.show = show
        self.signUpBuilder = signUpBuilder
        self.signInBuilder = signInBuilder
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
        signInCoordinator = signInBuilder.build(with: self)
        signInCoordinator?.start()
    }
}

// MARK: - SignUpListener implementation
extension AuthCoordinator: SignUpListener {
    func showSignIn() {
        signUpCoordinator?.stop(completion: { [weak self] in
            self?.signUpCoordinator = nil
        })
        routeSignIn()
    }

    func handleSignUp() {
        // TODO:
    }
}

// MARK: - SignInListener implementation
extension AuthCoordinator: SignInListener {
    func showSignUp() {
        signInCoordinator?.stop(completion: { [weak self] in
            self?.signInCoordinator = nil
        })
        routeSignUp()
    }

    func handleSignIn() {
        // TODO:
    }
}

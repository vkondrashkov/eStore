//
//  SignUpCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class SignUpCoordinator {
    private let scene: SignUpScene
    private let show: SignUpShow
    private weak var listener: SignUpListener?

    init(scene: SignUpScene,
         show: SignUpShow,
         listener: SignUpListener) {

        self.scene = scene
        self.show = show
        self.listener = listener
    }
}

// MARK: - Coordinator implementation
extension SignUpCoordinator: Coordinator {
    func start() {
        scene.play(signUpShow: show)
    }

    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

// MARK: - SignUpRouter implementation
extension SignUpCoordinator: SignUpRouter {
    func completeSignUp() {
        listener?.signUp()
    }
    
    func routeSignIn() {
        listener?.showSignIn()
    }
}

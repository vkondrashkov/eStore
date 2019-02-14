//
//  SignUpCoordinator.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class SignUpCoordinator {
    private let scene: SignUpScene
    private let show: SignUpShow

    init(scene: SignUpScene,
         show: SignUpShow) {
        self.scene = scene
        self.show = show
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

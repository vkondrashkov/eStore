//
//  RootCoordinator.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class RootCoordinator {
    private let scene: RootScene
    private let show: RootShow

    // Auth builder
    // Auth coordinator

    // Dashboard builder
    // Dashboard coordinator

    // TODO: Add builders to init
    init(scene: RootScene,
         show: RootShow) {
        self.scene = scene
        self.show = show
    }
}

// MARK: - Coordinator implementation
extension RootCoordinator: Coordinator {
    func start() {
        scene.play(rootShow: show)
    }

    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

// MARK: - RootRouter implementation
extension RootCoordinator: RootRouter {
    func showAuth() { }

    func showDashboard() { }
}

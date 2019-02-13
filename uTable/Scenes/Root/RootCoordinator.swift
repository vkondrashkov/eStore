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

    private let authBuilder: AuthBuilder
    private weak var authCoordinator: AuthCoordinator?

    private let dashboardBuilder: DashboardBuilder
    private weak var dashboardCoordinator: DashboardCoordinator?

    // TODO: Add builders to init
    init(scene: RootScene,
         show: RootShow,
         dashboardBuilder: DashboardBuilder,
         authBuilder: AuthBuilder) {
        self.scene = scene
        self.show = show
        self.dashboardBuilder = dashboardBuilder
        self.authBuilder = authBuilder
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
    func showAuth() {
        authCoordinator = authBuilder.build(with: self)
        authCoordinator?.start()
    }

    func showDashboard() {
        dashboardCoordinator = dashboardBuilder.build()
        dashboardCoordinator?.start()
    }
}

// MARK: AuthListener implementation
extension RootCoordinator: AuthListener {
    func authenticate() {
        authCoordinator?.stop(completion: { [weak self] in
            self?.authCoordinator = nil
        })
        showDashboard()
    }
}

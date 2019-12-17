//
//  RootCoordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class RootCoordinator {
    private let scene: RootScene
    private let show: RootShow

    private let authBuilder: AuthBuilder
    private var authCoordinator: AuthCoordinator?

    private let dashboardBuilder: DashboardBuilder
    private var dashboardCoordinator: DashboardCoordinator?

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
        dashboardCoordinator = dashboardBuilder.build(with: self)
        dashboardCoordinator?.start()
    }
}

// MARK: - AuthListener implementation
extension RootCoordinator: AuthListener {
    func authenticate() {
        authCoordinator?.stop(completion: { [weak self] in
            self?.authCoordinator = nil
        })
    }
}

// MARK: - DashboardListener implementation
extension RootCoordinator: DashboardListener {
    func logout() {
        dashboardCoordinator?.stop(completion: { [weak self] in
            self?.dashboardCoordinator = nil
        })
    }
}

//
//  DashboardCoordinator.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class DashboardCoordinator {
    private let scene: DashboardScene
    private let show: DashboardShow

    init(scene: DashboardScene,
         show: DashboardShow) {
        self.scene = scene
        self.show = show
    }
}

// MARK: - Coordinator implementation
extension DashboardCoordinator: Coordinator {
    func start() {
        scene.play(dashboardShow: show)
    }

    func stop(completion: (() -> Void)?) {
        completion?()
    }
}

// MARK: - DashboardRouter implementation
extension DashboardCoordinator: DashboardRouter { }

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

    private let profileBuilder: ProfileBuilder
    private var profileCoordinator: ProfileCoordinator?

    private let catalogBuilder: CatalogBuilder
    private var catalogCoordinator: CatalogCoordinator?

    // TODO: Change contract between Dash or Auth screen
    // with its Root module
    private weak var listener: DashboardListener?

    init(scene: DashboardScene,
         show: DashboardShow,
         profileBuilder: ProfileBuilder,
         catalogBuilder: CatalogBuilder,
         listener: DashboardListener) {

        self.scene = scene
        self.show = show
        self.profileBuilder = profileBuilder
        self.catalogBuilder = catalogBuilder
        self.listener = listener
    }
}

// MARK: - Coordinator implementation
extension DashboardCoordinator: Coordinator {
    func start() {
        scene.play(dashboardShow: show)

        profileCoordinator = profileBuilder.build(with: self)
        profileCoordinator?.start()

        catalogCoordinator = catalogBuilder.build()
        catalogCoordinator?.start()
    }

    func stop(completion: (() -> Void)?) {
        scene.finish(completion: completion)
    }
}

// MARK: - DashboardRouter implementation
extension DashboardCoordinator: DashboardRouter { }

// MARK: - ProfileListener implementation
extension DashboardCoordinator: ProfileListener {
    func logout() {
        profileCoordinator?.stop(completion: { [weak self] in
            self?.profileCoordinator = nil
        })
        listener?.logout()
    }
}

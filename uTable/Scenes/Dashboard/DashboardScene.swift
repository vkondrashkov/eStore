//
//  DashboardScene.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DashboardSceneImpl {
    let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
}

// MARK: - DashboardScene implementation
extension DashboardSceneImpl: DashboardScene {
    func play(dashboardShow: DashboardShow) {
        rootViewController.viewControllers = [dashboardShow.tabController]
    }
}

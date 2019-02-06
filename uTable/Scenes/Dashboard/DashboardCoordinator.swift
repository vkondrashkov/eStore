//
//  DashboardCoordinator.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class DashboardCoordinator {
    private let navigation: UINavigationController
    private let view: DashboardViewController

    // TimeTableBuilder
    // TimeTableCoordinator

    // ProfileBuilder
    // ProfileCoordinator
    // TODO: Add TimeTable and Profile builders to initializer

    init(navigation: UINavigationController,
         view: DashboardViewController) {
        self.navigation = navigation
        self.view = view
    }
}

// MARK: - Coordinator implementation
extension DashboardCoordinator: Coordinator {
    func start() {
        // TODO: start() method implementation
    }
}


// MARK: - DashboardRouter implementation
extension DashboardCoordinator: DashboardRouter {
    func routeTimeTable() {

    }

    func routeProfile() {

    }
}

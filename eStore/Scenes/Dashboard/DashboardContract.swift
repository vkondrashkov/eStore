//
//  DashboardContract.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol DashboardDependency: AnyObject {
    var parent: UIViewController { get }
}

protocol DashboardBuilder: AnyObject {
    func build() -> DashboardCoordinator
}

protocol DashboardScene: AnyObject {
    func play(dashboardShow: DashboardShow)
    func finish(completion: (() -> Void)?)
}

protocol DashboardShow: AnyObject {
    var tabController: UITabBarController { get }
}

protocol DashboardRouter: AnyObject { }

protocol DashboardListener {
    func logout() // TODO: Make method more functional
}

protocol DashboardView: AnyObject { }

protocol DashboardPresenter: AnyObject {
    func handleViewAppear()
}
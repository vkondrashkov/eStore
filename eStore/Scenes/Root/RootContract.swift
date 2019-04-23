//
//  RootContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol RootDependency: AnyObject {
    var parent: UIWindow { get }
    var themeManager: ThemeManager { get }
    var alertFactory: AlertFactory { get }
}

protocol RootBuilder: AnyObject {
    func build() -> RootCoordinator
}

protocol RootScene: AnyObject {
    func play(rootShow: RootShow)
}

protocol RootShow: AnyObject {
    var viewController: UIViewController { get }
}

protocol RootRouter: AnyObject {
    func showAuth()
    func showDashboard()
}

protocol RootView: AnyObject { }

protocol RootPresenter: AnyObject {
    func handleViewAppear()
}

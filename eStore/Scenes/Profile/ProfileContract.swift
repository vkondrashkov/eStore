//
//  ProfileContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol ProfileDependency: AnyObject {
    var profileNavigation: UINavigationController { get }
    var themeManager: ThemeManager { get }
    var alertFactory: AlertFactory { get }
}

protocol ProfileBuilder: AnyObject {
    func build(with listener: ProfileListener) -> ProfileCoordinator
}

protocol ProfileScene: AnyObject {
    func play(profileShow: ProfileShow)
}

protocol ProfileShow: AnyObject {
    var viewController: UIViewController { get }
}

protocol ProfileRouter: AnyObject {
    func logout()
    func showSettings()
    func showCart()
    func showContact()
    func showThemeSettings()
}

protocol ProfileListener: AnyObject {
    func logout()
}

protocol ProfileView: AnyObject, ThemeUpdatable, AlertDisplayable {
    func display(rightBarButton: String)
    func display(sections: [SectionedMenuSection])
}

protocol ProfilePresenter: AnyObject {
    func handleLoadView()
    func handleRightBarButtonPress()
}

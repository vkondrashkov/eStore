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
}

protocol ProfileListener: AnyObject {
    func logout()
}

protocol ProfileView: AnyObject {
    func display(rightBarButton: String)
    func display(sections: [ProfileSection])
    func display(alert: Alert)

    func update(theme: Theme)
}

protocol ProfilePresenter: AnyObject {
    func handleLoadView()
    func handleRightBarButtonPress()
}

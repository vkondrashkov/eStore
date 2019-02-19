//
//  ProfileContract.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol ProfileDependency: AnyObject {
    var profileNavigation: UINavigationController { get }
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

}

protocol ProfileListener: AnyObject {
    func logout()
}

protocol ProfileView: AnyObject {
    func display(rightBarButton: String)
    func display(emailCaption: String)
    func display(emailLabel: String)
    func display(logoutButton: String)
    func display(alert: Alert)
}

protocol ProfilePresenter: AnyObject {
    func handleLoadView()
    func handleRightBarButtonPress()
    func handleLogoutButtonPress()
}

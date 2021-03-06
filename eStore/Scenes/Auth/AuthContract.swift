//
//  AuthContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol AuthDependency: AnyObject {
    var parent: UIViewController { get }
    var authorizationRepository: AuthorizationRepository { get }
    var userRepository: UserRepository { get }
    var themeManager: ThemeManager { get }
    var userMapper: UserMapper { get }
    var alertFactory: AlertFactory { get }
}

protocol AuthBuilder: AnyObject {
    func build(with listener: AuthListener) -> AuthCoordinator
}

protocol AuthScene: AnyObject {
    func play(authShow: AuthShow)
    func finish(completion: (() -> Void)?)
}

protocol AuthShow: AnyObject {
    var navViewController: UINavigationController { get }
}

protocol AuthRouter: AnyObject {
    func routeSignUp()
    func routeSignIn()
}

protocol AuthListener: AnyObject {
    func authenticate() // TODO: Make method more functional
}

protocol AuthView: AnyObject, ThemeUpdatable { }

protocol AuthPresenter: AnyObject {
    func handleLoadView()
}

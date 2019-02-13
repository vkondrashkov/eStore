//
//  AuthContract.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol AuthDependency: AnyObject {
    var parent: UIViewController { get }
}

protocol AuthBuilder: AnyObject {
    func build(with listener: AuthListener) -> AuthCoordinator
}

protocol AuthScene: AnyObject {
    func play(authShow: AuthShow)
}

protocol AuthShow: AnyObject {
    var navViewController: UINavigationController { get }
}

protocol AuthRouter: AnyObject {
    func showSignUp()
    func showSignIn()
}

protocol AuthListener {
    func authenticate() // TODO: Make method more functional
}

protocol AuthView: AnyObject {
    func display(rightButton: String)
}

protocol AuthPresenter: AnyObject {
    func handleViewAppear()
}

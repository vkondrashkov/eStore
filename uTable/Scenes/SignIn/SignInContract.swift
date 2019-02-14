//
//  SignInContract.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/15/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol SignInDependency: AnyObject {
    var parent: UINavigationController { get }
}

protocol SignInBuilder: AnyObject {
    func build(with listener: SignInListener) -> SignInCoordinator
}

protocol SignInScene: AnyObject {
    func play(signInShow: SignInShow)
}

protocol SignInShow: AnyObject {
    var rootViewController: UIViewController { get }
}

protocol SignInListener: AnyObject {
    func showSignUp()
    func handleSignIn()
}

protocol SignInView: AnyObject {
    // TODO: Think over display(_:) methods
    func display(rightBarButton: String)
}

protocol SignInPresenter: AnyObject {
    func shouldViewAppear()
    func rightBarButtonDidPressed()
}

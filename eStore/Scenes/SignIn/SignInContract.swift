//
//  SignInContract.swift
//  eStore
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

protocol SignInRouter: AnyObject {
    func completeSignIn()
    func routeSignUp()
}

protocol SignInListener: AnyObject {
    func showSignUp()
    func signIn()
}

protocol SignInView: AnyObject {
    func display(rightBarButton: String)
    func display(emailCaption: String)
    func display(passwordCaption: String)
    func display(signInButton: String)
    func display(forgotPasswordButton: String)
    func display(alert: Alert)
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol SignInPresenter: AnyObject {
    func shouldViewAppear()
    func handleRightBarButtonPress()
    func handleForgotPasswordPress()
    func handleSignInButtonPress()
}

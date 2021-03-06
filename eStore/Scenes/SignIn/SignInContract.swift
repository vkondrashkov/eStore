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
    var themeManager: ThemeManager { get }
    var credentialsValidatorUseCase: CredentialsValidatorUseCase { get }
    var authorizationUseCase: AuthorizationUseCase { get }
    var alertFactory: AlertFactory { get }
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

protocol SignInView: AnyObject, ThemeUpdatable, AlertDisplayable {
    func display(rightBarButton: String)
    func display(emailCaption: String)
    func display(emailError: String)
    func display(passwordCaption: String)
    func display(passwordError: String)
    func display(signInButton: String)
    func display(forgotPasswordButton: String)
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol SignInPresenter: AnyObject {
    func shouldViewAppear()
    func handleRightBarButtonPress()
    func handleForgotPasswordPress()
    func handleSignInButtonPress(login: String?, password: String?)
}

enum SignInInteractorError: Error {
    case invalidData
    case failed
}

protocol SignInInteractor {
    func validate(email: String) -> Bool
    func validate(username: String) -> Bool
    func validate(password: String) -> Bool
    func signIn(login: String,
                password: String,
                completion: ((Result<User, SignInInteractorError>) -> Void)?)
}

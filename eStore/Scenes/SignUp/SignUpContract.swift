//
//  SignUpContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol SignUpDependency: AnyObject {
    var parent: UINavigationController { get }
    var credentialsValidatorUseCase: CredentialsValidatorUseCase { get }
    var authorizationUseCase: AuthorizationUseCase { get }
    var themeManager: ThemeManager { get }
    var alertFactory: AlertFactory { get }
}

protocol SignUpBuilder: AnyObject {
    func build(with listener: SignUpListener) -> SignUpCoordinator
}

protocol SignUpScene: AnyObject {
    func play(signUpShow: SignUpShow)
}

protocol SignUpShow: AnyObject {
    var rootViewController: UIViewController { get }
}

protocol SignUpRouter: AnyObject {
    func completeSignUp()
    func routeSignIn()
}

protocol SignUpListener: AnyObject {
    func showSignIn()
    func signUp()
}

protocol SignUpView: AnyObject, ThemeUpdatable, AlertDisplayable {
    func display(rightBarButton: String)
    func display(emailCaption: String)
    func display(emailError: String)
    func display(passwordCaption: String)
    func display(passwordError: String)
    func display(confirmPasswordCaption: String)
    func display(confirmPasswordError: String)
    func display(signUpButton: String)
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol SignUpPresenter: AnyObject {
    func shouldViewAppear()
    func handleRightBarButtonPress()
    func handleSignUpButtonPress(login: String?, password: String?, confirmPassword: String?)
}

enum SignUpInteractorError: Error {
    case invalidData
    case failed
}

protocol SignUpInteractor {
    func validate(email: String) -> Bool
    func validate(username: String) -> Bool
    func validate(password: String) -> Bool
    func signUp(login: String,
                password: String,
                completion: ((Result<User, SignUpInteractorError>) -> Void)?)
}

//
//  SignUpContract.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol SignUpDependency: AnyObject {
    var parent: UINavigationController { get }
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

protocol SignUpView: AnyObject {
    func display(rightBarButton: String)
    func display(emailCaption: String)
    func display(passwordCaption: String)
    func display(confirmPasswordCaption: String)
    func display(signUpButton: String)
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol SignUpPresenter: AnyObject {
    func shouldViewAppear()
    func handleRightBarButtonPress()
    func handleSignUpButtonPress()
}

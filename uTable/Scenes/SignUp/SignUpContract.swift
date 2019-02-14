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

protocol SignUpListener: AnyObject {
    func showSignIn()
    func handleSignUp()
}

protocol SignUpView: AnyObject {
    // TODO: Think over display(_:) methods
    func display(rightBarButton: String)
}

protocol SignUpPresenter: AnyObject {
    func shouldViewAppear()
    func rightBarButtonDidPressed()
}

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
    func build() -> SignUpCoordinator
}

protocol SignUpScene: AnyObject {
    func play(signUpShow: SignUpShow)
}

protocol SignUpShow: AnyObject {
    var rootViewController: UIViewController { get }
}

protocol SignUpRouter: AnyObject { }

protocol SignUpView: AnyObject {
    // TODO: Think over display(_:) methods
}

protocol SignUpPresenter: AnyObject {
    func handleViewAppear()
}

//
//  SignUpPresenter.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

final class SignUpPresenterImpl {
    private unowned let view: SignUpView
    private unowned let router: SignUpRouter

    init(view: SignUpView,
         router: SignUpRouter) {
        self.view = view
        self.router = router
    }
}

// MARK: - SignUpPresenter implementation
extension SignUpPresenterImpl: SignUpPresenter {
    func shouldViewAppear() {
        view.display(rightBarButton: "Sign In")
        view.display(emailCaption: "Email:")
        view.display(passwordCaption: "Password:")
        view.display(confirmPasswordCaption: "Confirm password:")
        view.display(signUpButton: "Sign Up")
    }

    func handleRightBarButtonPress() {
        router.routeSignIn()
    }

    func handleSignUpButtonPress() {
        view.showActivityIndicator()
        view.display(signUpButton: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.view.hideActivityIndicator()
            self?.view.display(signUpButton: "Sign Up")
            self?.router.completeSignUp()
        })
    }
    
}

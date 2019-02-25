//
//  SignUpPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

final class SignUpPresenterImpl {
    private unowned let view: SignUpView
    private weak var listener: SignUpListener?

    init(view: SignUpView,
         listener: SignUpListener) {
        self.view = view
        self.listener = listener
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
        listener?.showSignIn()
    }

    func handleSignUpButtonPress() {
        view.showActivityIndicator()
        view.display(signUpButton: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.view.hideActivityIndicator()
            self?.view.display(signUpButton: "Sign Up")
            self?.listener?.handleSignUp()
        })
    }
    
}

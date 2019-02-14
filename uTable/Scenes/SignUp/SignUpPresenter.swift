//
//  SignUpPresenter.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class SignUpPresenterImpl {
    private unowned let view: SignUpView
    private unowned let listener: SignUpListener

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

    func rightBarButtonDidPressed() {
        listener.showSignIn()
    }
}

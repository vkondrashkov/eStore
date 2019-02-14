//
//  SignInPresenter.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/15/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class SignInPresenterImpl {
    private unowned let view: SignInView
    private unowned let listener: SignInListener

    init(view: SignInView,
         listener: SignInListener) {
        self.view = view
        self.listener = listener
    }
}

// MARK: - SignInPresenter implementation
extension SignInPresenterImpl: SignInPresenter {
    func shouldViewAppear() {
        view.display(rightBarButton: "Sign Up")
    }

    func rightBarButtonDidPressed() {
        listener.showSignUp()
    }
}

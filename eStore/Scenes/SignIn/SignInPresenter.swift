//
//  SignInPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/15/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

final class SignInPresenterImpl {
    private unowned let view: SignInView
    private unowned let router: SignInRouter
    private unowned let themeManager: ThemeManager

    init(view: SignInView,
         router: SignInRouter,
         themeManager: ThemeManager) {

        self.view = view
        self.router = router
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }
}

// MARK: - SignInPresenter implementation
extension SignInPresenterImpl: SignInPresenter {
    func handleRightBarButtonPress() {
        router.routeSignUp()
    }

    func handleForgotPasswordPress() {
        let alert = Alert(
            title: "Oops...",
            message: "Unfortunately this feature is unavailable, try again later.",
            alertType: .singleAction,
            primaryCaption: "OK",
            primaryAction: nil,
            secondaryCaption: nil,
            secondaryAction: nil
        )
        view.display(alert: alert)
    }

    func handleSignInButtonPress() {
        view.showActivityIndicator()
        view.display(signInButton: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self?.view.hideActivityIndicator()
            self?.view.display(signInButton: "Sign In")
            self?.router.completeSignIn()
        })
    }

    func shouldViewAppear() {
        view.display(rightBarButton: "Sign Up")
        view.display(emailCaption: "Email:")
        view.display(passwordCaption: "Password:")
        view.display(signInButton: "Sign In")
        view.display(forgotPasswordButton: "Forgot password?")
    }
}

// MARK: - ThemeObserver implementation
extension SignInPresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) {
        view.apply(theme: theme, animated: true)
    }
}

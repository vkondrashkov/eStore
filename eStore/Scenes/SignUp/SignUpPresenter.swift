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
    private unowned let router: SignUpRouter
    private unowned let themeManager: ThemeManager

    init(view: SignUpView,
         router: SignUpRouter,
         themeManager: ThemeManager) {

        self.view = view
        self.router = router
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }
}

// MARK: - SignUpPresenter implementation
extension SignUpPresenterImpl: SignUpPresenter {
    func shouldViewAppear() {
        view.apply(theme: themeManager.currentTheme, animated: false)
        
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self?.view.hideActivityIndicator()
            self?.view.display(signUpButton: "Sign Up")
            self?.router.completeSignUp()
        })
    }
}

// MARK: - ThemeObserver implementation
extension SignUpPresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) {
        view.apply(theme: theme, animated: true)
    }
}


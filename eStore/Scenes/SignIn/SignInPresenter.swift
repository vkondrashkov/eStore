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

    func handleSignInButtonPress(login: String?, password: String?) {
        guard let unwrappedLogin = login, let unwrappedPassword = password else {
            if login?.isEmpty ?? true {
                view.display(emailError: "This field shouldn't be empty")
            }
            if password?.isEmpty ?? true {
                view.display(passwordError: "This field shouldn't be empty")
            }
            view.hideActivityIndicator()
            view.display(signInButton: "Sign In")
            return
        }
        view.showActivityIndicator()
        view.display(signInButton: "")
        let isUsernameValid = interactor.validate(username: unwrappedLogin)
        let isEmailValid = interactor.validate(email: unwrappedLogin)
        let isLoginValid = isUsernameValid || isEmailValid
        let isPasswordValid = interactor.validate(password: unwrappedPassword)

        guard isLoginValid, isPasswordValid else {
            if !isLoginValid {
                view.display(emailError: "Invalid email or login")
            }
            if !isPasswordValid {
                view.display(passwordError: "Invalid password")
            }
            view.hideActivityIndicator()
            view.display(signInButton: "Sign In")
            return
        }

        interactor.signIn(
            login: unwrappedLogin,
            password: unwrappedPassword,
            completion: { [weak self] result in
                switch result {
                case .success:
                    self?.view.hideActivityIndicator()
                    self?.view.display(signInButton: "Sign In")
                    self?.router.completeSignIn()
                case .failure(let error):
                    switch error {
                    case .failed:
                        let alert = Alert(
                            title: "Oops...",
                            message: "Something went wrong. Try again later.",
                            alertType: .singleAction,
                            primaryCaption: "OK",
                            primaryAction: nil,
                            secondaryCaption: nil,
                            secondaryAction: nil
                        )
                        self?.view.display(alert: alert)
                        self?.view.hideActivityIndicator()
                        self?.view.display(signInButton: "Sign In")
                    case .invalidData:
                        let alert = Alert(
                            title: "Oops...",
                            message: "User with given data doesn't exist.",
                            alertType: .singleAction,
                            primaryCaption: "OK",
                            primaryAction: nil,
                            secondaryCaption: nil,
                            secondaryAction: nil
                        )
                        self?.view.display(alert: alert)
                        self?.view.hideActivityIndicator()
                        self?.view.display(signInButton: "Sign In")
                    }
                }
            }
        )
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
        view.update(theme: theme, animated: false)
    }
}

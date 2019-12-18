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
    private let interactor: SignUpInteractor
    private unowned let themeManager: ThemeManager

    init(view: SignUpView,
         router: SignUpRouter,
         interactor: SignUpInteractor,
         themeManager: ThemeManager) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
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

    func handleSignUpButtonPress(login: String?,
                                 password: String?,
                                 confirmPassword: String?) {
        guard let unwrappedLogin = login,
            let unwrappedPassword = password,
            let unwrappedConfirmPassword = confirmPassword else {
                if login?.isEmpty ?? true {
                    view.display(emailError: "This field shouldn't be empty")
                }
                if password?.isEmpty ?? true {
                    view.display(passwordError: "This field shouldn't be empty")
                }
                if confirmPassword?.isEmpty ?? true {
                    view.display(confirmPasswordError: "Shouldn't be empty")
                }
                view.hideActivityIndicator()
                view.display(signUpButton: "Sign Up")
                return
        }
        view.showActivityIndicator()
        view.display(signUpButton: "")
        let isUsernameValid = interactor.validate(username: unwrappedLogin)
        let isEmailValid = interactor.validate(email: unwrappedLogin)
        let isLoginValid = isUsernameValid || isEmailValid
        let isPasswordValid = interactor.validate(password: unwrappedPassword)
        let isConfirmPasswordValid = unwrappedConfirmPassword == unwrappedPassword

        guard isLoginValid, isPasswordValid, isConfirmPasswordValid else {
            if !isLoginValid {
                view.display(emailError: "Invalid email or login")
            }
            if !isPasswordValid {
                view.display(passwordError: "Invalid password")
            }
            if !isConfirmPasswordValid {
                view.display(confirmPasswordError: "Doesn't match")
            }
            view.hideActivityIndicator()
            view.display(signUpButton: "Sign In")
            return
        }

        interactor.signUp(
            login: unwrappedLogin,
            password: unwrappedPassword,
            completion: { [weak self] result in
                switch result {
                case .success:
                    self?.view.hideActivityIndicator()
                    self?.view.display(signUpButton: "Sign In")
                    self?.router.completeSignUp()
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
                        self?.view.display(signUpButton: "Sign In")
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
                        self?.view.display(signUpButton: "Sign In")
                    }
                }
            }
        )
    }
}

// MARK: - ThemeObserver implementation
extension SignUpPresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) {
        view.update(theme: theme, animated: false)
    }
}


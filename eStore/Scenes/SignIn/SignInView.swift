//
//  SignInView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/15/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignInViewImpl: UIViewController {
    var presenter: SignInPresenter!

    private var containerView: UIView!
    private var emailCaption: UILabel!
    private var emailTextField: UITextField!
    private var passwordCaption: UILabel!
    private var passwordTextField: UITextField!
    private var confirmPasswordCaption: UILabel!
    private var confirmPasswordTextField: UITextField!
    private var signInButton: UIButton!
    private var forgotPasswordButton: UIButton!
    private var activityIndicator: UIActivityIndicatorView!

    private let signInButtonBackgroundColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
    private let customTintColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
    private let forgotPasswordButtonRegularColor = UIColor(white: 0.5, alpha: 1.0)
    private let forgotPasswordButtonHighlightedColor = UIColor(white: 0.75, alpha: 1.0)

    private lazy var keyboardManager = KeyboardManager(viewController: self)

    override func loadView() {
        view = UIView()

        containerView = UIView()
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.width.equalTo(300)
            make.leading.greaterThanOrEqualToSuperview().offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
        }

        emailCaption = UILabel()
        containerView.addSubview(emailCaption)
        emailCaption.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        emailTextField = UITextField()
        containerView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailCaption.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        passwordCaption = UILabel()
        containerView.addSubview(passwordCaption)
        passwordCaption.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }

        passwordTextField = UITextField()
        containerView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordCaption.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        signInButton = UIButton()
        containerView.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        forgotPasswordButton = UIButton()
        containerView.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(10)
            make.centerX.bottom.equalToSuperview()
        }

        activityIndicator = UIActivityIndicatorView()
        signInButton.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Sign In"
        navigationController?.navigationBar.tintColor = customTintColor

        emailCaption.font = .boldSystemFont(ofSize: 17)

        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress

        passwordCaption.font = .boldSystemFont(ofSize: 17)

        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true

        signInButton.addTarget(self, action: #selector(signInButtonDidPressed), for: .touchUpInside)
        signInButton.layer.cornerRadius = 5
        signInButton.layer.masksToBounds = true
        signInButton.backgroundColor = signInButtonBackgroundColor

        forgotPasswordButton.setTitleColor(forgotPasswordButtonRegularColor, for: .normal)
        forgotPasswordButton.setTitleColor(forgotPasswordButtonHighlightedColor, for: .highlighted)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonDidPressed), for: .touchUpInside)

        activityIndicator.style = .white

        keyboardManager.hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.shouldViewAppear()
    }

    @objc func rightBarButtonDidPressed() {
        presenter.handleRightBarButtonPress()
    }

    @objc func signInButtonDidPressed() {
        presenter.handleSignInButtonPress()
    }

    @objc func forgotPasswordButtonDidPressed() {
        presenter.handleForgotPasswordPress()
    }
}

// MARK: - SignInView implementation
extension SignInViewImpl: SignInView {
    func display(rightBarButton: String) {
        let rightBarButtonItem = UIBarButtonItem(title: rightBarButton,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(rightBarButtonDidPressed))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func display(emailCaption: String) {
        self.emailCaption.text = emailCaption
    }

    func display(passwordCaption: String) {
        self.passwordCaption.text = passwordCaption
    }

    func display(signInButton: String) {
        self.signInButton.setTitle(signInButton, for: .normal)
    }

    func display(forgotPasswordButton: String) {
        self.forgotPasswordButton.setTitle(forgotPasswordButton, for: .normal)
    }

    func display(alert: Alert) {
        let alertController = AlertFactory().make(alert: alert)
        present(alertController, animated: true, completion: nil)
    }

    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - SignInShow implementation
extension SignInViewImpl: SignInShow {
    var rootViewController: UIViewController {
        return self
    }
}

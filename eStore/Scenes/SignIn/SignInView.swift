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
    var alertFactory: AlertFactory!
    var theme: Theme!

    private var containerView: UIView!
    private var emailCaption: UILabel!
    private var emailStatusLabel: UILabel!
    private var emailTextField: UITextField!
    private var passwordCaption: UILabel!
    private var passwordStatusLabel: UILabel!
    private var passwordTextField: UITextField!
    private var signInButton: UIButton!
    private var forgotPasswordButton: UIButton!
    private var activityIndicator: UIActivityIndicatorView!

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

        emailStatusLabel = UILabel()
        containerView.addSubview(emailStatusLabel)
        emailStatusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(emailTextField.snp.top).offset(-10)
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

        passwordStatusLabel = UILabel()
        containerView.addSubview(passwordStatusLabel)
        passwordStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(passwordTextField.snp.top).offset(-10)
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
        title = "Sign In"

        emailCaption.font = .boldSystemFont(ofSize: 17)

        emailStatusLabel.font = .boldSystemFont(ofSize: 17)
        emailStatusLabel.textAlignment = .right

        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress

        passwordCaption.font = .boldSystemFont(ofSize: 17)

        passwordStatusLabel.font = .boldSystemFont(ofSize: 17)
        passwordStatusLabel.textAlignment = .right

        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true

        signInButton.addTarget(self, action: #selector(signInButtonDidPressed), for: .touchUpInside)
        signInButton.layer.cornerRadius = 5
        signInButton.layer.masksToBounds = true

        forgotPasswordButton.setTitleColor(Color.grey, for: .normal)
        forgotPasswordButton.setTitleColor(Color.silver, for: .highlighted)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonDidPressed), for: .touchUpInside)

        activityIndicator.style = .white

        apply(theme: theme)
        keyboardManager.hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.shouldViewAppear()
    }

    @objc private func rightBarButtonDidPressed() {
        presenter.handleRightBarButtonPress()
    }

    @objc private func signInButtonDidPressed() {
        presenter.handleSignInButtonPress(
            login: emailTextField.text,
            password: passwordTextField.text
        )
    }

    @objc private func forgotPasswordButtonDidPressed() {
        presenter.handleForgotPasswordPress()
    }

    private func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        emailCaption.textColor = theme.textColor
        emailTextField.backgroundColor = theme.foregroundColor
        emailTextField.textColor = theme.textColor
        passwordCaption.textColor = theme.textColor
        passwordTextField.backgroundColor = theme.foregroundColor
        passwordTextField.textColor = theme.textColor
        signInButton.backgroundColor = theme.tintColor
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

    func display(emailError: String) {
        self.emailStatusLabel.text = emailError
        self.emailStatusLabel.textColor = Color.redPigment
    }

    func display(passwordCaption: String) {
        self.passwordCaption.text = passwordCaption
    }

    func display(passwordError: String) {
        self.passwordStatusLabel.text = passwordError
        self.passwordStatusLabel.textColor = Color.redPigment
    }

    func display(signInButton: String) {
        self.signInButton.setTitle(signInButton, for: .normal)
    }

    func display(forgotPasswordButton: String) {
        self.forgotPasswordButton.setTitle(forgotPasswordButton, for: .normal)
    }

    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - AlertDisplayable implementation
extension SignInViewImpl: AlertDisplayable {
    func display(alert: Alert) {
        let alertController = alertFactory.make(alert: alert)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - ThemeUpdatable implementation
extension SignInViewImpl: ThemeUpdatable {
    func update(theme: Theme, animated: Bool) {
        self.theme = theme

        var animation: CircularFillAnimation?
        if animated {
            animation = CircularFillAnimation(
                view: view,
                position: CGPoint(x: 300, y: 545), // TODO: make tap recognizier
                contextType: .window
            )
            animation?.prepare()
        }

        apply(theme: theme)

        animation?.run(completion: nil)
    }
}

// MARK: - SignInShow implementation
extension SignInViewImpl: SignInShow {
    var rootViewController: UIViewController {
        return self
    }
}

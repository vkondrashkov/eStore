//
//  SignUpView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignUpViewImpl: UIViewController {
    var presenter: SignUpPresenter!
    var theme: Theme!

    private var containerView: UIView!
    private var emailCaption: UILabel!
    private var emailTextField: UITextField!
    private var passwordCaption: UILabel!
    private var passwordTextField: UITextField!
    private var confirmPasswordCaption: UILabel!
    private var confirmPasswordTextField: UITextField!
    private var signUpButton: UIButton!
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

        confirmPasswordCaption = UILabel()
        containerView.addSubview(confirmPasswordCaption)
        confirmPasswordCaption.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }

        confirmPasswordTextField = UITextField()
        containerView.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordCaption.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        signUpButton = UIButton()
        containerView.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
        }

        activityIndicator = UIActivityIndicatorView()
        signUpButton.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sign Up"

        emailCaption.font = .boldSystemFont(ofSize: 17)

        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress

        passwordCaption.font = .boldSystemFont(ofSize: 17)

        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true

        confirmPasswordCaption.font = .boldSystemFont(ofSize: 17)

        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.isSecureTextEntry = true

        signUpButton.addTarget(self, action: #selector(signUpButtonDidPressed), for: .touchUpInside)
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.masksToBounds = true

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

    @objc private func signUpButtonDidPressed() {
        presenter.handleSignUpButtonPress(
            login: emailTextField.text,
            password: passwordTextField.text,
            confirmPassword: confirmPasswordTextField.text
        )
    }

    private func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        emailCaption.textColor = theme.textColor
        emailTextField.backgroundColor = theme.foregroundColor
        emailTextField.textColor = theme.textColor
        passwordCaption.textColor = theme.textColor
        passwordTextField.backgroundColor = theme.foregroundColor
        passwordTextField.textColor = theme.textColor
        confirmPasswordCaption.textColor = theme.textColor
        confirmPasswordTextField.backgroundColor = theme.foregroundColor
        confirmPasswordTextField.textColor = theme.textColor
        signUpButton.backgroundColor = theme.tintColor
    }
}

// MARK: - ThemeUpdatable implementation
extension SignUpViewImpl: ThemeUpdatable {
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

// MARK: - SignUpView implementation
extension SignUpViewImpl: SignUpView {
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

    func display(confirmPasswordCaption: String) {
        self.confirmPasswordCaption.text = confirmPasswordCaption
    }

    func display(signUpButton: String) {
        self.signUpButton.setTitle(signUpButton, for: .normal)
    }

    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - SignUpShow implementation
extension SignUpViewImpl: SignUpShow {
    var rootViewController: UIViewController {
        return self
    }
}

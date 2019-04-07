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

        view.backgroundColor = Color.background
        title = "Sign Up"
        navigationController?.navigationBar.tintColor = Color.shamrock

        emailCaption.font = .boldSystemFont(ofSize: 17)
        emailCaption.textColor = Color.text

        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.backgroundColor = Color.foreground
        emailTextField.textColor = Color.text

        passwordCaption.font = .boldSystemFont(ofSize: 17)
        passwordCaption.textColor = Color.text

        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = Color.foreground
        passwordTextField.textColor = Color.text

        confirmPasswordCaption.font = .boldSystemFont(ofSize: 17)
        confirmPasswordCaption.textColor = Color.text

        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.backgroundColor = Color.foreground
        confirmPasswordTextField.textColor = Color.text

        signUpButton.addTarget(self, action: #selector(signUpButtonDidPressed), for: .touchUpInside)
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.masksToBounds = true
        signUpButton.backgroundColor = Color.shamrock

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

    @objc func signUpButtonDidPressed() {
        presenter.handleSignUpButtonPress()
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

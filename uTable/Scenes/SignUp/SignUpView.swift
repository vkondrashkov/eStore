//
//  SignUpView.swift
//  uTable
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

    private let signUpButtonBackgroundColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)

    private lazy var keyboardManager = KeyboardManager(viewController: self)

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        containerView = UIView()

        setupEmailCaption()
        setupEmailTextField()
        setupPasswordCaption()
        setupPasswordTextField()
        setupConfirmPasswordCaption()
        setupConfirmPasswordTextField()
        setupSignUpButton()

        view.addSubview(containerView)
        activateContainerViewConstraints(view: containerView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardManager.hideKeyboardWhenTappedAround()
    }

    private func setupEmailCaption() {
        emailCaption = UILabel()
        emailCaption.font = .boldSystemFont(ofSize: 17)
        containerView.addSubview(emailCaption)
        activateEmailCaptionConstraints(view: emailCaption)
    }

    private func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        containerView.addSubview(emailTextField)
        activateEmailTextFieldConstraints(view: emailTextField, anchorView: emailCaption)
    }

    private func setupPasswordCaption() {
        passwordCaption = UILabel()
        passwordCaption.font = .boldSystemFont(ofSize: 17)
        containerView.addSubview(passwordCaption)
        activatePasswordCaptionConstraints(view: passwordCaption, anchorView: emailTextField)
    }

    private func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        containerView.addSubview(passwordTextField)
        activatePasswordTextFieldConstraints(view: passwordTextField, anchorView: passwordCaption)
    }

    private func setupConfirmPasswordCaption() {
        confirmPasswordCaption = UILabel()
        confirmPasswordCaption.font = .boldSystemFont(ofSize: 17)
        containerView.addSubview(confirmPasswordCaption)
        activateConfirmPasswordCaptionConstraints(view: confirmPasswordCaption, anchorView: passwordTextField)
    }

    private func setupConfirmPasswordTextField() {
        confirmPasswordTextField = UITextField()
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.isSecureTextEntry = true
        containerView.addSubview(confirmPasswordTextField)
        activateConfirmPasswordTextFieldConstraints(view: confirmPasswordTextField, anchorView: confirmPasswordCaption)
    }

    private func setupSignUpButton() {
        signUpButton = UIButton()
        signUpButton.addTarget(self, action: #selector(signUpButtonDidPressed), for: .touchUpInside)
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.masksToBounds = true
        signUpButton.backgroundColor = signUpButtonBackgroundColor
        containerView.addSubview(signUpButton)
        activateSignUpButtonConstraints(view: signUpButton, anchorView: confirmPasswordTextField)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.shouldViewAppear()
    }

    @objc func rightBarButtonDidPressed() {
        presenter.rightBarButtonDidPressed()
    }

    @objc func signUpButtonDidPressed() {
        
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
}

// MARK: - SignUpShow implementation
extension SignUpViewImpl: SignUpShow {
    var rootViewController: UIViewController {
        return self
    }
}

// MARK: - Constraints
private extension SignUpViewImpl {
    func activateEmailCaptionConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ])
    }

    func activateEmailTextFieldConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    func activatePasswordCaptionConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 20),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ])
    }

    func activatePasswordTextFieldConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    func activateConfirmPasswordCaptionConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 20),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ])
    }

    func activateConfirmPasswordTextFieldConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    func activateSignUpButtonConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 20),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            view.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    func activateContainerViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            view.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 50),
            view.widthAnchor.constraint(equalToConstant: 300)
            ])
    }
}

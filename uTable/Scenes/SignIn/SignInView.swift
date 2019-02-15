//
//  SignInView.swift
//  uTable
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
    private var forgotPasswordLabel: UILabel!

    private let signInButtonBackgroundColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
    private let forgotPasswordLabelColor = UIColor(white: 0.75, alpha: 1.0)

    private lazy var keyboardManager = KeyboardManager(viewController: self)

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        containerView = UIView()

        setupEmailCaption()
        setupEmailTextField()
        setupPasswordCaption()
        setupPasswordTextField()
        setupSignInButton()
        setupForgotPasswordLabel()

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

    private func setupSignInButton() {
        signInButton = UIButton()
        signInButton.addTarget(self, action: #selector(signInButtonDidPressed), for: .touchUpInside)
        signInButton.layer.cornerRadius = 5
        signInButton.layer.masksToBounds = true
        signInButton.backgroundColor = signInButtonBackgroundColor
        containerView.addSubview(signInButton)
        activateSignInButtonConstraints(view: signInButton, anchorView: passwordTextField)
    }

    private func setupForgotPasswordLabel() {
        forgotPasswordLabel = UILabel()
        forgotPasswordLabel.textColor = forgotPasswordLabelColor
        forgotPasswordLabel.textAlignment = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordLabelDidPressed))
        forgotPasswordLabel.addGestureRecognizer(tapGesture)
        containerView.addSubview(forgotPasswordLabel)
        activateForgotPasswordLabelConstraints(view: forgotPasswordLabel, anchorView: signInButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.shouldViewAppear()
    }

    @objc func rightBarButtonDidPressed() {
        presenter.rightBarButtonDidPressed()
    }

    @objc func signInButtonDidPressed() {

    }

    @objc func forgotPasswordLabelDidPressed() {

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

    func display(forgotPasswordLabel: String) {
        self.forgotPasswordLabel.text = forgotPasswordLabel
    }
}

// MARK: - SignInShow implementation
extension SignInViewImpl: SignInShow {
    var rootViewController: UIViewController {
        return self
    }
}

// MARK: - Constraints
private extension SignInViewImpl {
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

    func activateSignInButtonConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 20),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    func activateForgotPasswordLabelConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
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

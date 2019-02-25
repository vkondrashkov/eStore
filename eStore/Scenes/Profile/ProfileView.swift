//
//  ProfileView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileViewImpl: UIViewController {
    var presenter: ProfilePresenter!

    private var containerView: UIView!
    private var emailCaption: UILabel!
    private var emailLabel: UILabel!
    private var logoutButton: UIButton!

    private let logoutButtonOffset: CGFloat = 10
    private let regularFont: UIFont = .systemFont(ofSize: 17)
    private let heavyFont: UIFont = .boldSystemFont(ofSize: 24)

    private let customTintColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Profile"
        navigationController?.navigationBar.tintColor = customTintColor
        containerView = UIView()

        setupEmailCaption()
        setupEmailLabel()
        setupLogoutButton()

        view.addSubview(containerView)
        activateContainerViewConstraints(view: containerView)
        presenter.handleLoadView()
    }

    private func setupEmailCaption() {
        emailCaption = UILabel()
        emailCaption.font = heavyFont
        containerView.addSubview(emailCaption)
        activateEmailCaptionConstraints(view: emailCaption)
    }

    private func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.font = regularFont
        containerView.addSubview(emailLabel)
        activateEmailLabelConstraints(view: emailLabel, anchorView: emailCaption)
    }

    private func setupLogoutButton() {
        logoutButton = UIButton()
        logoutButton.setTitleColor(.red, for: .normal)
        logoutButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        logoutButton.addTarget(self, action: #selector(logoutButtonDidPressed), for: .touchUpInside)
        view.addSubview(logoutButton)
        activateSetupLogoutButtonConstraints(view: logoutButton)
    }

    @objc private func rightBarButtonDidPressed() {
        presenter.handleRightBarButtonPress()
    }

    @objc private func logoutButtonDidPressed() {
        presenter.handleLogoutButtonPress()
    }
}

// MARK: - ProfileView implementation
extension ProfileViewImpl: ProfileView {
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

    func display(emailLabel: String) {
        self.emailLabel.text = emailLabel
    }

    func display(logoutButton: String) {
        self.logoutButton.setTitle(logoutButton, for: .normal)
    }

    func display(alert: Alert) {
        let alertController = AlertFactory().make(alert: alert)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - ProfileShow implementation
extension ProfileViewImpl: ProfileShow {
    var viewController: UIViewController {
        return self
    }
}

// MARK: - Constraints
private extension ProfileViewImpl {
    func activateEmailCaptionConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ])
    }

    func activateEmailLabelConstraints(view: UIView, anchorView: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ])
    }

    func activateSetupLogoutButtonConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            view.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: logoutButtonOffset)
            ])
    }

    func activateContainerViewConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 20),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 20)
            ])
    }
}

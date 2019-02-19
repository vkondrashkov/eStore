//
//  ProfileView.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class ProfileViewImpl: UIViewController {
    var presenter: ProfilePresenter!

    private var logoutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLogoutButton()

        presenter.handleLoadView()
    }

    private func setupLogoutButton() {
        logoutButton = UIButton()
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        logoutButton.addTarget(self, action: #selector(logoutButtonDidPressed), for: .touchUpInside)
        view.addSubview(logoutButton)
        activateSetupLogoutButtonConstraints(view: logoutButton)
    }

    @objc private func logoutButtonDidPressed() {
        presenter.handleLogoutButtonPress()
    }
}

// MARK: - ProfileView implementation
extension ProfileViewImpl: ProfileView {
    func display(logoutButton: String) {
        self.logoutButton.setTitle(logoutButton, for: .normal)
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
    // TODO: Refactor constraints method
    func activateSetupLogoutButtonConstraints(view: UIView) {
        guard let superview = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ])
    }
}

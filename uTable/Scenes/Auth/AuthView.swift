//
//  AuthView.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class AuthViewImpl: UINavigationController {
    var presenter: AuthPresenter!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.handleViewAppear()

        view.backgroundColor = .purple // Debug only
    }

    @objc func rightBarButtonDidPressed() {
        presenter.rightBarButtonDidPressed()
    }
}

// MARK: - AuthView implementation
extension AuthViewImpl: AuthView {
    func display(rightButton: String) {
        let rightBarButton = UIBarButtonItem(
            title: rightButton,
            style: .plain,
            target: self,
            action: #selector(rightBarButtonDidPressed)
        )
        navigationItem.rightBarButtonItem = rightBarButton
    }
}

// MARK: - AuthShow implementation
extension AuthViewImpl: AuthShow {
    var navViewController: UINavigationController {
        return self
    }
}

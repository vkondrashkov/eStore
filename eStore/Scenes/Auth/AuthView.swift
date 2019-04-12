//
//  AuthView.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class AuthViewImpl: UINavigationController {
    var presenter: AuthPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        modalTransitionStyle = .crossDissolve
        navigationBar.prefersLargeTitles = true
        presenter.handleLoadView()
    }
}

// MARK: - AuthView implementation
extension AuthViewImpl: AuthView { }

// MARK: - ThemeSupportable implementation
extension AuthViewImpl: ThemeSupportable {
    func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        navigationBar.tintColor = theme.tintColor
        navigationBar.barTintColor = theme.barColor
        navigationBar.barStyle = theme.barStyle
        navigationBar.titleTextAttributes = [.foregroundColor: theme.textColor]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: theme.textColor]
    }
}

// MARK: - AuthShow implementation
extension AuthViewImpl: AuthShow {
    var navViewController: UINavigationController {
        return self
    }
}

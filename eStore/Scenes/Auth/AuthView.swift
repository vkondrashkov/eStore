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
    var theme: Theme!

    override func viewDidLoad() {
        super.viewDidLoad()
        modalTransitionStyle = .crossDissolve
        navigationBar.prefersLargeTitles = true

        apply(theme: theme)
        presenter.handleLoadView()
    }

    private func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        navigationBar.tintColor = theme.tintColor
        navigationBar.barTintColor = theme.barColor
        navigationBar.barStyle = theme.barStyle
        navigationBar.titleTextAttributes = [.foregroundColor: theme.textColor]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: theme.textColor]
    }
}

// MARK: - AuthView implementation
extension AuthViewImpl: AuthView { }

// MARK: - ThemeUpdatable implementation
extension AuthViewImpl: ThemeUpdatable {
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

// MARK: - AuthShow implementation
extension AuthViewImpl: AuthShow {
    var navViewController: UINavigationController {
        return self
    }
}

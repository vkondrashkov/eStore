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
        view.backgroundColor = Color.background
        navigationBar.tintColor = Color.shamrock
        navigationBar.barTintColor = Color.navigationBar
        navigationBar.titleTextAttributes = [.foregroundColor: Color.text]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: Color.text]
        navigationBar.prefersLargeTitles = true
        navigationBar.barStyle = Themes.value(from: [.light: .default, .dark: .black])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - AuthView implementation
extension AuthViewImpl: AuthView { }

// MARK: - AuthShow implementation
extension AuthViewImpl: AuthShow {
    var navViewController: UINavigationController {
        return self
    }
}

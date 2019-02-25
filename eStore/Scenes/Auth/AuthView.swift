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

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        modalTransitionStyle = .crossDissolve
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

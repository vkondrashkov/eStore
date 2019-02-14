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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.handleViewAppear()

        view.backgroundColor = .yellow // Debug only
    }
}

// MARK: - SignUpView implementation
extension SignUpViewImpl: SignUpView { }

// MARK: - SignUpShow implementation
extension SignUpViewImpl: SignUpShow {
    var rootViewController: UIViewController {
        return self
    }
}

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

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.shouldViewAppear()
    }

    @objc func rightBarButtonDidPressed() {
        presenter.rightBarButtonDidPressed()
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
}

// MARK: - SignUpShow implementation
extension SignUpViewImpl: SignUpShow {
    var rootViewController: UIViewController {
        return self
    }
}

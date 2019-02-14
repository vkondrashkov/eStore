//
//  SignUpPresenter.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class SignUpPresenterImpl {
    private unowned let view: SignUpView
    private let router: SignUpRouter

    init(view: SignUpView,
         router: SignUpRouter) {
        self.view = view
        self.router = router
    }
}

// MARK: - AuthPresenter implementation
extension SignUpPresenterImpl: SignUpPresenter {
    func handleViewAppear() { }
}

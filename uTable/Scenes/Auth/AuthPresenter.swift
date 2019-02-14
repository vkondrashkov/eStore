//
//  AuthPresenter.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class AuthPresenterImpl {
    private unowned let view: AuthView
    private let router: AuthRouter

    init(view: AuthView,
         router: AuthRouter) {
        self.view = view
        self.router = router
    }
}

// MARK: - AuthPresenter implementation
extension AuthPresenterImpl: AuthPresenter {
    func handleViewAppear() {
        view.display(rightButton: "Sign In") // Temp
    }

    func rightBarButtonDidPressed() {
        view.display(rightButton: "Sign Up") // Temp
    }
}

//
//  AuthPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/14/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class AuthPresenterImpl {
    private unowned let view: AuthView
    private unowned let router: AuthRouter
    private unowned let themeManager: ThemeManager

    init(view: AuthView,
         router: AuthRouter,
         themeManager: ThemeManager) {

        self.view = view
        self.router = router
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }
}

// MARK: - AuthPresenter implementation
extension AuthPresenterImpl: AuthPresenter {
    func handleLoadView() {
        view.apply(theme: themeManager.currentTheme)
        router.routeSignUp()
    }
}

// MARK: - ThemeObserver implementation
extension AuthPresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) {
        view.apply(theme: theme)
    }
}

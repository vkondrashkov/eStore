//
//  DashboardPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class DashboardPresenterImpl {
    private unowned let view: DashboardView
    private unowned let router: DashboardRouter
    private unowned let themeManager: ThemeManager

    init(view: DashboardView,
         router: DashboardRouter,
         themeManager: ThemeManager) {

        self.view = view
        self.router = router
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }
}

// MARK: - DashboardPresenter implementation
extension DashboardPresenterImpl: DashboardPresenter {
    func shouldViewAppear() {
        view.apply(theme: themeManager.currentTheme)
    }
}

// MARK: - ThemeObserver implementation
extension DashboardPresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) {
        view.apply(theme: theme)
    }
}

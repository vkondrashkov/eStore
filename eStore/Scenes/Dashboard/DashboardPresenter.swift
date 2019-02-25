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

    init(view: DashboardView,
         router: DashboardRouter) {
        self.view = view
        self.router = router
    }
}

// MARK: - DashboardPresenter implementation
extension DashboardPresenterImpl: DashboardPresenter { }

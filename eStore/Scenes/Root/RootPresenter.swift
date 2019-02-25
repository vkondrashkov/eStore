//
//  RootPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class RootPresenterImpl {
    private unowned let view: RootView
    private unowned let router: RootRouter

    init(view: RootView,
         router: RootRouter) {
        self.view = view
        self.router = router
    }
}

// MARK: - RootPresenter implementation
extension RootPresenterImpl: RootPresenter {
    func handleViewAppear() {
        router.showAuth()
    }
}

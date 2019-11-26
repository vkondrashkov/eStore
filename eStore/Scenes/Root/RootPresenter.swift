//
//  RootPresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/13/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

final class RootPresenterImpl {
    private unowned let view: RootView
    private unowned let router: RootRouter
    private let interactor: RootInteractor

    init(view: RootView,
         router: RootRouter,
         interactor: RootInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - RootPresenter implementation
extension RootPresenterImpl: RootPresenter {
    func handleViewAppear() {
//        router.showAuth()
        interactor.loadUser(completion: { [weak self] succeed in
            DispatchQueue.main.async {
                if succeed {
                    self?.router.showDashboard()
                } else {
                    self?.router.showAuth()
                }
            }
        })
    }
}

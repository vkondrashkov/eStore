//
//  ProfilePresenter.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ProfilePresenterImpl {
    private unowned let view: ProfileView
    private let router: ProfileRouter

    init(view: ProfileView,
         router: ProfileRouter) {
        self.view = view
        self.router = router
    }
}

// MARK: - RootPresenter implementation
extension ProfilePresenterImpl: ProfilePresenter {
    func handleViewAppear() { }
}

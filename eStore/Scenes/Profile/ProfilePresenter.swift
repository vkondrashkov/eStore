//
//  ProfilePresenter.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ProfilePresenterImpl {
    private unowned let view: ProfileView
    private unowned var listener: ProfileListener
    private let router: ProfileRouter

    init(view: ProfileView,
         router: ProfileRouter,
         listener: ProfileListener) {

        self.view = view
        self.router = router
        self.listener = listener
    }
}

// MARK: - RootPresenter implementation
extension ProfilePresenterImpl: ProfilePresenter {
    func handleLoadView() {
        view.display(logoutButton: "Log out")
    }

    func handleLogoutButtonPress() {
        listener.logout()
    }
}

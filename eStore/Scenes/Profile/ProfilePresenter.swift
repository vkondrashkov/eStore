//
//  ProfilePresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ProfilePresenterImpl {
    private unowned let view: ProfileView
    private unowned let router: ProfileRouter

    init(view: ProfileView,
         router: ProfileRouter) {

        self.view = view
        self.router = router
    }

    private func handleCartCategoryPress() {

    }

    private func handleSettingsCategoryPress() {

    }
}

// MARK: - ProfilePresenter implementation
extension ProfilePresenterImpl: ProfilePresenter {
    func handleLoadView() {
        view.display(rightBarButton: "Edit")

        let userCategory = ProfileCategoryImpl(name: "USERNAME", iconUrl: nil, onTapAction: nil)
        let cartCategory = ProfileCategoryImpl(name: "Cart", iconUrl: nil, onTapAction: { [weak self] in
            self?.handleCartCategoryPress()
        })
        let settingsCategory = ProfileCategoryImpl(name: "Settings", iconUrl: nil, onTapAction: { [weak self] in
            self?.handleSettingsCategoryPress()
        })
        let profileCategories: [ProfileCategory] = [
            userCategory,
            cartCategory,
            settingsCategory
        ]
        view.display(profileCategories: profileCategories)

        view.display(logoutButton: "Log out")
    }

    func handleRightBarButtonPress() {
        let alert = Alert(
            title: "Oops...",
            message: "Unfortunately this feature is unavailable, try again later.",
            alertType: .singleAction,
            primaryCaption: "OK",
            primaryAction: nil,
            secondaryCaption: nil,
            secondaryAction: nil
        )
        view.display(alert: alert)
    }

    func handleLogoutButtonPress() {
        let alert = Alert(
            title: "Logout confirmation",
            message: "Are you sure you want to log out?",
            alertType: .doubleAction,
            primaryCaption: "OK",
            primaryAction: { [weak self] in
                self?.router.logout()
            },
            secondaryCaption: "Cancel",
            secondaryAction: nil
        )
        view.display(alert: alert)
    }
}

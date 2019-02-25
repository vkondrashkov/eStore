//
//  ProfilePresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ProfilePresenterImpl {
    private unowned let view: ProfileView
    private weak var listener: ProfileListener?
    private unowned let router: ProfileRouter

    init(view: ProfileView,
         router: ProfileRouter,
         listener: ProfileListener) {

        self.view = view
        self.router = router
        self.listener = listener
    }
}

// MARK: - ProfilePresenter implementation
extension ProfilePresenterImpl: ProfilePresenter {
    func handleLoadView() {
        view.display(rightBarButton: "Edit")
        view.display(emailCaption: "Email")
        view.display(emailLabel: "myemail@example.com")
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
                self?.listener?.logout()
            },
            secondaryCaption: "Cancel",
            secondaryAction: nil
        )
        view.display(alert: alert)
    }
}

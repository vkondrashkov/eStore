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
    private let interactor: ProfileInteractor
    private unowned let themeManager: ThemeManager

    init(view: ProfileView,
         router: ProfileRouter,
         interactor: ProfileInteractor,
         themeManager: ThemeManager) {

        self.view = view
        self.router = router
        self.interactor = interactor
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }

    private func handleCartCategoryPress() {
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

    private func handleSettingsCategoryPress() {
        router.showSettings()
    }

    private func handleContactCategoryPress() {
        router.showContact()
    }

    func handleLogoutCategoryPress() {
        let alert = Alert(
            title: "Logout confirmation",
            message: "Are you sure you want to log out?",
            alertType: .doubleAction,
            primaryCaption: "OK",
            primaryAction: { [weak self] in
                self?.interactor.logout(completion: { error in
                    guard error == nil else {
                        return
                    }
                    self?.router.logout()
                })
            },
            secondaryCaption: "Cancel",
            secondaryAction: nil
        )
        view.display(alert: alert)
    }

    private func handleThemeSettingsCategoryPress() {
        router.showThemeSettings()
    }
}

// MARK: - ProfilePresenter implementation
extension ProfilePresenterImpl: ProfilePresenter {
    func handleLoadView() {
        guard let user = interactor.currentUser else {
            router.logout()
            return
        }

        let userRow = SectionedMenuRow(
            imageUrl: "",
            title: user.fullname ?? user.username,
            type: .thumbnail,
            action: nil
        )
        let userSection = SectionedMenuSection(title: nil, items: [userRow])

        let cartRow = SectionedMenuRow(
            imageUrl: "cart-icon",
            title: "Cart",
            action: { [weak self] _ in
                self?.handleCartCategoryPress()
            }
        )
        let cartSection = SectionedMenuSection(title: "Cart", items: [cartRow])

        let settingsRow = SectionedMenuRow(
            imageUrl: "settings-icon",
            title: "Settings",
            action: { [weak self] _ in
                self?.handleSettingsCategoryPress()
            }
        )
        let contactsRow = SectionedMenuRow(
            imageUrl: "help-icon",
            title: "Contact us",
            action: { [weak self] _ in
                self?.handleContactCategoryPress()
            }
        )
        let themeRow = SectionedMenuRow(
            imageUrl: "theme-settings-icon",
            title: "Appearance",
            action: { [weak self] _ in
                self?.handleThemeSettingsCategoryPress()
            }
        )
        let helpSection = SectionedMenuSection(title: "Help", items: [settingsRow, contactsRow, themeRow])

        let logoutRow = SectionedMenuRow(
            imageUrl: "exit-icon",
            title: "Log out",
            action: { [weak self] _ in
                self?.handleLogoutCategoryPress()
            }
        )
        let logoutSection = SectionedMenuSection(title: nil, items: [logoutRow])

        let sections = [userSection, cartSection, helpSection, logoutSection]
        view.display(sections: sections)
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
}

// MARK: - ThemeObserver implementation
extension ProfilePresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) {
        view.update(theme: theme, animated: false)
    }
}

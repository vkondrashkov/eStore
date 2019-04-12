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
    private unowned let themeManager: ThemeManager

    init(view: ProfileView,
         router: ProfileRouter,
         themeManager: ThemeManager) {

        self.view = view
        self.router = router
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

    private func handleLogoutCategoryPress() {
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

// MARK: - ProfilePresenter implementation
extension ProfilePresenterImpl: ProfilePresenter {
    func handleLoadView() {
        view.apply(theme: themeManager.currentTheme, animated: false)
        view.display(rightBarButton: "Edit")

        let userCategory = ProfileCategoryImpl(name: "Vladislav Kondrashkov", iconUrl: "https://pp.userapi.com/c846420/v846420977/17f606/5X3A9gQCaY8.jpg?ava=1", type: .thumbnail, onTapAction: nil)
        let userSection = ProfileSection(name: nil, categories: [userCategory])

        let cartCategory = ProfileCategoryImpl(name: "Cart", iconUrl: "cart-icon", onTapAction: { [weak self] in
            self?.handleCartCategoryPress()
        })
        let cartSection = ProfileSection(name: "Cart", categories: [cartCategory])

        let settingsCategory = ProfileCategoryImpl(name: "Settings", iconUrl: "settings-icon", onTapAction: { [weak self] in
            self?.handleSettingsCategoryPress()
        })
        let contactCategory = ProfileCategoryImpl(name: "Contact us", iconUrl: "help-icon", onTapAction: { [weak self] in
            self?.handleContactCategoryPress()
        })
        let themeCategory = ProfileCategoryImpl(name: "Theme", iconUrl: "settings-icon", onTapAction: { [weak self] in
            guard let self = self else { return }
            let newThemeType: ThemeType = self.themeManager.currentTheme.type == .light ? .dark : .light
            let newTheme = ThemeBuilderImpl().build(type: newThemeType)
            UserDefaultsManager.theme = newThemeType
            self.themeManager.applyTheme(newTheme)
        })
        let helpSection = ProfileSection(name: "Help", categories: [settingsCategory, contactCategory, themeCategory])

        let logoutCategory = ProfileCategoryImpl(name: "Log out", iconUrl: "exit-icon", type: .warning, onTapAction: { [weak self] in
            self?.handleLogoutCategoryPress()
        })
        let logoutSection = ProfileSection(name: nil, categories: [logoutCategory])

        let sections = [userSection,cartSection, helpSection, logoutSection]
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
        view.apply(theme: theme, animated: true)
    }
}

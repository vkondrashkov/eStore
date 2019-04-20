//
//  ThemePresenter.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/7/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ThemeSettingsPresenterImpl {
    private unowned let view: ThemeSettingsView
    private unowned let themeManager: ThemeManager

    init(view: ThemeSettingsView,
         themeManager: ThemeManager) {
        self.view = view
        self.themeManager = themeManager
        self.themeManager.add(observer: self)
    }
}

// MARK: - ThemeSettingsPresenter implementation
extension ThemeSettingsPresenterImpl: ThemeSettingsPresenter {
    func handleLoadView() {
        let darkThemeRow = SectionedMenuRow(
            imageUrl: nil,
            title: "Dark",
            action: { [weak self] tapPoint in
                guard let self = self else { return }
                guard self.themeManager.currentTheme.type != .dark else { return }
                let newTheme = ThemeBuilderImpl().build(type: .dark)
                UserDefaultsManager.theme = .dark
                self.themeManager.applyTheme(newTheme)
                self.view.update(theme: newTheme, from: tapPoint, animated: true)
            }
        )
        let lightThemeRow = SectionedMenuRow(
            imageUrl: nil,
            title: "Light",
            action: { [weak self] tapPoint in
                guard let self = self else { return }
                guard self.themeManager.currentTheme.type != .light else { return }
                let newTheme = ThemeBuilderImpl().build(type: .light)
                UserDefaultsManager.theme = .light
                self.themeManager.applyTheme(newTheme)
                self.view.update(theme: newTheme, from: tapPoint, animated: true)
            }
        )
        let userSection = SectionedMenuSection(title: "Color theme", items: [darkThemeRow, lightThemeRow])


        let sections = [userSection]
        view.display(sections: sections)
    }
}

// MARK: - ThemeObserver implementation
extension ThemeSettingsPresenterImpl: ThemeObserver {
    func didChangedTheme(_ theme: Theme) { }
}

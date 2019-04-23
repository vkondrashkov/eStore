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
            imageUrl: "dark-theme-icon",
            title: "Dark",
            action: { [weak self] tapPoint in
                guard let self = self else { return }
                guard self.themeManager.currentTheme.type != .dark else { return }
                let currentTheme = self.themeManager.currentTheme
                let newTheme = ThemeBuilderImpl().build(type: .dark, tintColorType: currentTheme.tintColorType)
                self.themeManager.applyTheme(newTheme)
                self.view.update(theme: newTheme, from: tapPoint, animated: true)
            }
        )
        let lightThemeRow = SectionedMenuRow(
            imageUrl: "light-theme-icon",
            title: "Light",
            action: { [weak self] tapPoint in
                guard let self = self else { return }
                guard self.themeManager.currentTheme.type != .light else { return }
                let currentTheme = self.themeManager.currentTheme
                let newTheme = ThemeBuilderImpl().build(type: .light, tintColorType: currentTheme.tintColorType)
                self.themeManager.applyTheme(newTheme)
                self.view.update(theme: newTheme, from: tapPoint, animated: true)
            }
        )
        let themeSection = SectionedMenuSection(title: "Color theme", items: [darkThemeRow, lightThemeRow])

        let colorPickerRow = SectionedMenuRow(
            imageUrl: "color-picker-icon",
            title: "Accent color",
            type: .colorPicker,
            action: { [weak self] _ in
                self?.view.display(colorPickerItems: [.shamrock, .cinnabar, .saturatedSky, .riseAndShine, .azraqBlue, .picoPink])
            }
        )
        let colorPickerSection = SectionedMenuSection(title: nil, items: [colorPickerRow])

        let sections = [themeSection, colorPickerSection]
        view.display(sections: sections)
    }

    func handlePickedTintColor(tintColorType: TintColorType) {
        let currentTheme = self.themeManager.currentTheme
        let newTheme = ThemeBuilderImpl().build(type: currentTheme.type, tintColorType: tintColorType)
        self.themeManager.applyTheme(newTheme)
        self.view.update(theme: newTheme, animated: false)
    }
}

// MARK: - ThemeObserver implementation
extension ThemeSettingsPresenterImpl: ThemeObserver {
    // Observer can't get point of touch, so
    // presenter would update theme by itself
    func didChangedTheme(_ theme: Theme) { }
}

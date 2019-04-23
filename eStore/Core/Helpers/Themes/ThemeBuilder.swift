//
//  ThemeBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/11/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

protocol ThemeBuilder {
    func build(type: ThemeType, tintColorType: TintColorType) -> Theme
}

class ThemeBuilderImpl: ThemeBuilder {
    func build(type: ThemeType, tintColorType: TintColorType) -> Theme {
        let theme: Theme
        switch type {
        case .dark:
            theme = DarkTheme(tintColorType: tintColorType)
        case .light:
            theme = LightTheme(tintColorType: tintColorType)
        }
        return theme
    }
}

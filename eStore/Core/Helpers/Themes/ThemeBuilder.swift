//
//  ThemeBuilder.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/11/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

protocol ThemeBuilder {
    func build(type: ThemeType) -> Theme
}

class ThemeBuilderImpl: ThemeBuilder {
    func build(type: ThemeType) -> Theme {
        let theme: Theme
        switch type {
        case .dark:
            theme = DarkTheme()
        case .light:
            theme = LightTheme()
        }
        return theme
    }
}

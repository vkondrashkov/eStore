//
//  Themes.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/7/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

enum ThemeType {
    case light
    case dark
    case any
}

struct Themes {
    static var currentTheme: ThemeType {
        return .dark // TODO: Make integration to UserDefaults
    }

    static func value<T>(from values: [ThemeType: T]) -> T {
        return values[currentTheme] ?? values[.light]!
    }
}

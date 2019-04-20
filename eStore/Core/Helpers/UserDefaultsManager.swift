//
//  UserDefaultsManager.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/7/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

struct UserDefaultsKeys {
    static var theme = "Theme"
    static var tintColor = "TintColor"
}

struct UserDefaultsManager {
    static var theme: ThemeType {
        get {
            return ThemeType(rawValue: UserDefaults.standard.integer(forKey: UserDefaultsKeys.theme)) ?? .light
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: UserDefaultsKeys.theme)
        }
    }

    static var tintColor: TintColorType {
        get {
            return TintColorType(rawValue: UserDefaults.standard.integer(forKey: UserDefaultsKeys.tintColor)) ?? .azraqBlue
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: UserDefaultsKeys.tintColor)
        }
    }
}

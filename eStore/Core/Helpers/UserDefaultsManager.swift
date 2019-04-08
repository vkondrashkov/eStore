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
}

struct UserDefaultsManager {
    static var theme: Theme {
        get {
            guard let data = UserDefaults.standard.object(forKey: UserDefaultsKeys.theme) as? Data,
                let themeValue = try? NSKeyedUnarchiver.unarchivedObject(ofClass: Theme.self, from: data),
                let theme = themeValue else {
                    assertionFailure("Cant load")
                    return LightTheme()
            }
            return theme
        }
        set {
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: true) else {
                assertionFailure("Cant save")
                return
            }
            UserDefaults.standard.set(data, forKey: UserDefaultsKeys.theme)
        }
    }
}

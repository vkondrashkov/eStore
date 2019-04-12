//
//  ThemeManager.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/8/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

protocol ThemeManager: AnyObject {
    var currentTheme: Theme { get }
    func applyTheme(_ theme: Theme)
    func add(observer: ThemeObserver)
    func remove(observer: ThemeObserver)
}

final class ThemeManagerImpl: ThemeManager {
    private var observers: [WeakRef<AnyObject>] = []

    var currentTheme: Theme {
        return ThemeBuilderImpl().build(type: UserDefaultsManager.theme)
    }

    func applyTheme(_ theme: Theme) {
        UserDefaultsManager.theme = theme.type
        for weakObserver in observers {
            guard let observer = weakObserver.value as? ThemeObserver else { continue }
            observer.didChangedTheme(theme)
        }
    }

    func add(observer: ThemeObserver) {
        guard !observers.contains(where: { $0.value === observer as AnyObject }) else {
            return
        }
        observers.append(WeakRef<AnyObject>(value: observer as AnyObject))
    }

    func remove(observer: ThemeObserver) {
        observers.removeAll(where: { $0.value === observer as AnyObject })
    }
}

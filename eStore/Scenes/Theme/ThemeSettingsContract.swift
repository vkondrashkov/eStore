//
//  ThemeContract.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/7/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol ThemeSettingsDependency: AnyObject {
    var navigation: UINavigationController { get }
    var themeManager: ThemeManager { get }
}

protocol ThemeSettingsBuilder: AnyObject {
    func build() -> ThemeSettingsCoordinator
}

protocol ThemeSettingsScene: AnyObject {
    func play(themeSettingsShow: ThemeSettingsShow)
}

protocol ThemeSettingsShow: AnyObject {
    var viewController: UIViewController { get }
}

protocol ThemeSettingsRouter: AnyObject { }

protocol ThemeSettingsView: AnyObject, ThemeUpdatable {
    func display(sections: [SectionedMenuSection])
    func display(alert: Alert)
}

protocol ThemeSettingsPresenter: AnyObject {
    func handleLoadView()
}

//
//  AppDelegate.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import Moya
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var rootCoordinator: RootCoordinator!
    
    // MARK: - Application lifecycle
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let themeManager = ThemeManagerImpl()
        let alertFactory = AlertFactoryImpl()

        let component = AppComponent(
            window: window,
            authorizationRepository: AuthorizationRepositoryImpl(
                provider: MoyaProvider<eStoreAPI>(),
                userMapper: UserMapperImpl()
            ),
            userRepository: UserRepositoryImpl(),
            themeManager: themeManager,
            alertFactory: alertFactory
        )
        let builder = RootBuilderImpl(dependency: component)

        rootCoordinator = builder.build()
        rootCoordinator?.start()

        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}


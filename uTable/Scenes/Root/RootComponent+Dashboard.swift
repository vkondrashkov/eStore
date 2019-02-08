//
//  RootComponent+Dashboard.swift
//  uTable
//
//  Created by Vladislav Kondrashkov on 2/8/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

extension RootComponent: DashboardDependency {
    var navigation: UITabBarController {
        return rootViewController
    }
}

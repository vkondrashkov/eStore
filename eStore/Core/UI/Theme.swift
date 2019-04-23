//
//  Theme.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/8/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol Theme {
    var type: ThemeType { get }
    var barColor: UIColor { get }
    var barStyle: UIBarStyle { get }
    var backgroundColor: UIColor { get }
    var foregroundColor: UIColor { get }
    var borderColor: UIColor { get }
    var textColor: UIColor { get }
    var tintColorType: TintColorType { get }
    var tintColor: UIColor { get }
}

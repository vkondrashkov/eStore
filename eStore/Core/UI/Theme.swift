//
//  Theme.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/8/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class Theme {
    var type: ThemeType
    var barColor: UIColor
    var barStyle: UIBarStyle
    var backgroundColor: UIColor
    var foregroundColor: UIColor
    var borderColor: UIColor
    var textColor: UIColor
    var tintColor: UIColor

    init() {
        type = .clear
        barColor = .clear
        barStyle = .default
        backgroundColor = .clear
        foregroundColor = .clear
        borderColor = .clear
        textColor = .clear
        tintColor = .clear
    }
}

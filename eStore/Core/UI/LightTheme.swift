//
//  LightTheme.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/8/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class LightTheme: Theme {
    let type: ThemeType = .light
    let barColor = Color.whiteLilac
    let barStyle: UIBarStyle = .default
    let backgroundColor = Color.solitude
    let foregroundColor = Color.white
    let borderColor = Color.silver
    let textColor = Color.black
    let tintColorType: TintColorType
    let tintColor: UIColor

    init(tintColorType: TintColorType) {
        self.tintColorType = tintColorType
        self.tintColor = tintColorType.color
    }
}

//
//  LightTheme.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/8/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class LightTheme: Theme {
    override init() {
        super.init()
        type = .light
        barColor = Color.whiteLilac
        backgroundColor = Color.solitude
        foregroundColor = Color.white
        borderColor = Color.silver
        textColor = Color.black
        tintColor = Color.shamrock
    }
}

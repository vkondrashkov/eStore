//
//  DarkTheme.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/8/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DarkTheme: Theme {
    override init() {
        super.init()
        type = .dark
        barColor = Color.nero
        backgroundColor = Color.black
        foregroundColor = Color.nightRider
        borderColor = Color.codGrey
        textColor = Color.white
        tintColor = Color.shamrock
    }
}

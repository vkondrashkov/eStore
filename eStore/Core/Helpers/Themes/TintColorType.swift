//
//  TintColorType.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

enum TintColorType: Int {
    case shamrock
    case cinnabar
    case saturatedSky
    case riseAndShine
    case azraqBlue
    case picoPink

    var color: UIColor {
        switch self {
        case .shamrock:
            return Color.shamrock
        case .cinnabar:
            return Color.cinnabar
        case .saturatedSky:
            return Color.saturatedSky
        case .riseAndShine:
            return Color.riseAndShine
        case .azraqBlue:
            return Color.azraqBlue
        case .picoPink:
            return Color.picoPink
        }
    }
}

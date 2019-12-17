//
//  OperatingSystem.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

enum OperatingSystem: Int {
    case iOS = 0
    case Android
    case MacOs
    case Windows
    case Linux
    case WebOs
    case unknown
}

extension OperatingSystem {
    var title: String {
        switch self {
        case .iOS:
            return "iOS"
        case .Android:
            return "Android"
        case .MacOs:
            return "MacOs"
        case .Windows:
            return "Windows"
        case .Linux:
            return "Linux"
        case .WebOs:
            return "WebOs"
        case .unknown:
            return "unknown"
        }
    }
}
